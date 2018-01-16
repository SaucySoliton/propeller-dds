' 

'
' This FM transmitter was hacked together to 
' demonstrate and test the direct digital synthesizer. 
' 
' Audio input is via PWM.  
' This is to be compatible with many common objects
' that use a counter in duty mode for audio output.
' 
' 
' No pre-emphasis (yet), so sound will seem a bit muffled. 
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

OBJ
  dds     : "dds_2bit"
  
VAR
  long parameter
  long dds_tune_addr
  long dds_clock_freq


PUB start(freq,daclsb, left )    ' freq is Hz,  basepin ,  pwm audio input pin 
  dds.start(daclsb)
  txp_ftw := dds.get_tune_addr
  dds_clock_freq := dds.get_clock_freq
  
  repeat while freq > dds_clock_freq   ' 
     freq -= dds_clock_freq
     
  if freq > (dds_clock_freq/2)        ' reduce freq to get below the Nyquist 
     freq := dds_clock_freq - freq
  
  dds.tune(freq)                      ' set tables for center frequency 
  txp_sampletime := 320               ' number of clocks between counter reads
                                      ' also the peak-to-peak input value
  txp_devscale := ratio( 75_000*2 , dds_clock_freq )/txp_sampletime   
                                      ' We want peak-to-peak audio to generate peak-to-peak 
                                      ' modulation. By loading this value into FRQA, the counter 
                                      ' does the multiplication automatically. 
  txp_basetune := ratio ( freq-75_000 , dds_clock_freq )   ' quick and dirty way to center modulation
  txp_pin := left   ' audio input pin, assumes PWM in duty mode 
  
  cognew(@txcog, @parameter)
  
     
      
PUB ratio( num, denom) : r
  ' compute the 32-bit fixed-point representation of num / denom (so num must be =< denom)
  repeat 32                      
    num <<= 1
    r <<= 1
    if num => denom    '  
      num -= denom
      r++


  
DAT
      'assembly code starts here'
      org
txcog
                
                mov    frqa,txp_devscale   
                movs   ctra,txp_pin
                movi   ctra,#%01000_000    ' POS detect
                           
                           
                mov     time, cnt 
                add     time,txp_sampletime
txloop          waitcnt time,txp_sampletime
                mov     newphs,phsa
                mov     modval,newphs
                sub     modval,oldphs           ' find the delta 
                add     modval,txp_basetune    
                mov     oldphs,newphs
                rol     modval,#13              ' 
                wrlong  modval,txp_ftw
                jmp     #txloop
                



' Parameters that are set up by Spin code prior to cognew()
txp_pin         long      0 
txp_ftw         long      0
txp_basetune    long      0
txp_devscale    long      0  
txp_sampletime  long      0 



' Variables 

newphs    long 0 
oldphs    long 0
modval    long 0
time      long 0

'  Constants
one       long $ffff_ffff
zero      long 0



' res must go after long

fit

