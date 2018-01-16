' 
' High Speed RF Direct Digital Synthesizer for Propeller 
' 
' 
' 2 bit output at 80MSPS, when using 80MHz clkfreq
' Uses the standard Propeller composite video dac circuit. 
' 
' Uses the counters of 1 cog, can operate set and forget if 
' frequency changes are not needed. 

' This began with the idea that the counters could generate 
' a 2 bit triangular wave. 
' 
' 000222000222000  <- Fundamental
' 101010101010101  <- Third harmonic 
' 101232101232101  <- Sum
' 
'    ___   ___
' ___   ___   ___  <- Fundamental
' -_-_-_-_-_-_-_-  <- Third harmonic 
'    _-_   _-_
' -_-   -_-   -_-  <- Sum
' 
' A triangular wave still has fairly strong harmonics, which 
' are a nuisance for RF applications. Since we are building our 
' own DAC from resistors, we can use any weighting we want. 
' Reducing the strength of the third harmonic from 1/2 to 1/4 
' to that of the fundamental produced a signal that looked more 
' like a sine wave. The harmonics seen in the spectrum were 
' also reduced. 
'
' Further analysis suggested that the optimal value is 1/3. 
' Recall from the Fourier expansion of a square wave that 
' the third harmonic has 1/3 the amplitude of the fundamental. 
' By using a 1/3 weight for the second bit we can exactly 
' cancel the third harmonic. Also note that the third harmonic 
' signal we generate must be out of phase with the fundamental. 
' 
' This method could be extended to more harmonics. The problem is 
' the output converges to a sine wave much more slowly than with 
' 2^N weighting. For example, the 3rd harmonic signal also cancels 
' the 15th (5*3). When we cancel the 5th, we add the 15th back. 
' Simulations with up to 6 output bits were much worse than would 
' be expected from a 6 bit DAC. It also seemed difficult to 
' eliminate spurious signals below the desired output. These 
' are very undesirable as they require a bandpass filter to 
' clean the output instead of the lowpass theoretically required. 
' 
' 
' There are still lots of vestigial code and notes from the table-based DDS. 
' 
' Usage:
' dds.start(12)  ' For composite video dac on pins 12:14 FIXME: Currently hardcoded
'
' dds.tune( 10_450_000 )      ' Set the frequency to 10.45 MHz. 
'                             ' Output will mute while 
'                             ' tables are recalculated
'                             ' and PLLs are resynchronized. 
' 
' dds.modulate( 10_450_100 )  ' For small frequency changes 
'                             ' without muting output, continuous phase. 
'                             ' Caller is responsible for ensuring 
'                             ' that the deviation is acceptable.
'                             ' Should call tune() first. 
' 
' 
' It should be possible to transmit FM stereo with this code. 
' Keep in mind that you'll need to program an image frequency 
' as the FM band exceeds the Nyquist frequency for this code. 
' Also keep in mind that the output has lots of spurious frequencies 
' and should not be used for anything other than a parlor trick. 
' 
' 
' 
' 
' 
' Copyright (C) 2018 SaucySoliton
' 
' 

{{

TERMS OF USE: MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

}}


'CON
'  _clkmode = xtal1 + pll16x
'  _XinFREQ = 5_000_000



  
VAR
  long parameter
  long dds_tune
  long dds_sync_time
  long dds_clock_freq
  long this_pin


PUB start(basepin)    'basepin is LSB,   MSB is basepin+2 

  ddsp_tune := @dds_tune            ' configure memory address for dds tuning frequency
  ddsp_time := @dds_sync_time       ' and sync time
  
  dds_sync_time := cnt + 8_000_000  ' This initial value should be meaningless


  dds_clock_freq := clkfreq '(clkfreq*8)/5   ' Calculate once since we don't expect 
                                    ' sysclock to change.
                    
  dds_tune :=  0                    ' 0 means wait for new frequency
                              

  ddsp_phd    := 32 ' Post-hub delay
                    ' It's basically a magic number more easily 
                    ' found by trial and error.

                    ' Tuning procedure:
                    ' Replace   "mov phsa,phsaval" with "nop"
                    ' Adjust magic number phd
                    ' Restore  "mov phsa,phsaval"
                    ' Adjust magic number phsaval factor

  this_pin    :=  basepin+2    
  txp_pin     := 7<<(basepin)
  ddsp_vgrp   := this_pin/8
  ddsp_shift  := 7
  cognew(@srccog, @parameter)
  waitcnt( 9_000 + cnt )
  
  
  this_pin    :=  basepin+1    
  txp_pin     := 1<<(this_pin)
  ddsp_vgrp   := this_pin/8
  ddsp_shift  := 6
  ddsp_phd    := ddsp_phd-2     ' each cog is 2 cycles later
 ' cognew(@srccog, @parameter)
  waitcnt( 9_000 + cnt )
  
  
  this_pin    :=  basepin+0    
  txp_pin     := 1<<(this_pin)
  ddsp_vgrp   := this_pin/8
  ddsp_shift  := 5
  ddsp_phd    := ddsp_phd-2  
'  cognew(@srccog, @parameter)
  waitcnt( 9_000 + cnt )
  
     
      
PUB ratio( num, denom) : r
  ' compute the 32-bit fixed-point representation of num / denom (so num must be =< denom)
  repeat 32                      
    num <<= 1
    r <<= 1
    if num => denom    '  
      num -= denom
      r++

PUB modulate( freq ) 
  dds_tune :=  ratio( freq , dds_clock_freq )<-13  ' This should be in PASM
                                                   
PUB tune( freq )
  dds_tune :=  0
  waitcnt( 9_000 + cnt )
  dds_sync_time := cnt + 800_000  ' There is room for improvement here
  dds_tune :=  ratio( freq , dds_clock_freq )<-13  ' This should be in PASM

PUB get_tune_addr : a
  a := @dds_tune

PUB get_clock_freq : f
  f := dds_clock_freq
  
  
DAT
      'assembly code starts here'
      org
srccog


entry        
                             
                mov     frqa,#0
                mov     frqb,#0
                movi    ctra, #%0_00100_111     ' NCO
                movi    ctrb, #%0_00101_111     ' NCO
                mov     phsa,#0
                mov     phsb,phsbval                   
                
                or      dira,txp_pin
                movs    ctra,#14
                movs    ctrb,#13  ' FIXME
                movd    ctrb,#12  ' FIXME
   

vidloop       

                rdlong  M,ddsp_tune   wz       
                ror     M,#13
                mov     newfrqb,M
                add     newfrqb,M
                add     newfrqb,M
                mov     tempfrqb,newfrqb
                shl     tempfrqb,#1         ' Compensation for the time difference in 
                sub     tempfrqb,lastfrqb   ' writing FRQx. Second counter runs at 
                mov     lastfrqb,newfrqb    ' (2*new)-old for 4 clocks to catch up to the first. 
                mov     frqa,M
                mov     frqb,tempfrqb
                mov     frqb,newfrqb
                
  
                jmp     #vidloop
  
        if_nz   jmp     #vidloop
        ' If we get here, we have received a signal to retune the tables 


         '       jmp     #waitforfreq   



' Parameters that are set up by Spin code prior to cognew()
ddsp_tune       long      0
ddsp_time       long      0
ddsp_vgrp       long      0
ddsp_shift      long      6
ddsp_phd        long      16
txp_pin         long      0 


' Variables 

accu      long 0 
wptr      long 0
rptr      long 0
temp      long 0
slice     long 0
loopi     long 0
loopj     long 0 
wait      long 0 
cref      long 0 
M         long 1 
lastfrqb  long 0
newfrqb   long 0
tempfrqb  long 0

'  Constants
frqaval    long $1999_999a  
phsbval    long $8000_0000       ' phsaval magic number is the factor at the end
                                      

'clr_send long $ffaa5500 '(255)<<8    ' for 4 color mode
clr_send   long $ffff_ff00
vscl_long  long 1<<12 + 32


one       long $ffff_ffff
zero      long 0



' res must go after long

fit

