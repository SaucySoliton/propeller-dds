
' This is a lightly modified Retronitus demo
' with FM transmitter connected. 

CON
    _clkmode  = xtal1 | pll16x
    _xinfreq  = 5_000_000
    left_pin  = 9
    right_pin = 10

OBJ
    sound   :   "Retronitus"
'
    tx      :   "fmtx_3bit"                 ' Just 2 lines to add FM transmitter 
 '   tx      :   "fmtx_pll"                 ' Just 2 lines to add FM transmitter 
                                            ' 
PUB Main
    sound.start(left_pin, right_pin)
    sound.playMusic(@music)
    tx.start(  87_700_000 , 12 , left_pin ) ' Just 2 lines to add FM transmiter 
                                            ' frequency, composite video LSB, audio PWM pin 
    
   ' waitcnt(cnt + 80_000_000)
    'sound.playSoundEffect(5 ,@sfx1)
   ' sound.playSoundEffect(5 ,@sfx2)
    repeat
       waitcnt(cnt + 320_000_000)
      ' sound.playSoundEffect(5 ,@sfx1)
      ' sound.playSoundEffect(5 ,@sfx2)
dat
sfx1 file "Bell.rsd"
sfx2 file "CarHorn_sqr.rsd"

dat
              long  0
music
              word  0
instrArray    word  @kick                  -@instrArray
              word  @hiHatOpen             -@instrArray
              word  @mainLead              -@instrArray
              word  @bass                  -@instrArray  
              word  @chord                 -@instrArray
              word  @pluck                 -@instrArray
              word  0
                   
patternSelect word  @patternSeqBass        -@instrArray
              word  @patternSeqChord1      -@instrArray
              word  @patternSeqChord2      -@instrArray
              word  @patternSeqMainMelody1 -@instrArray
              word  @patternSeqMainMelody2 -@instrArray
              word  0'@patternSeqChord3      -@instrArray
              word  @patternSeqTriangle    -@instrArray
              word  @patternSeqNoise       -@instrArray
            
dat
patternSeqBass
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (8<<28) | (0<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (8<<28) | (0<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (1<<24) | (3<<16) |          (@bassPattern3 -@instrArray) 
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (4<<24) | (3<<16) |          (@bassPattern3 -@instrArray) 
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (1<<24) | (3<<16) |          (@bassPattern3 -@instrArray) 
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (4<<24) | (3<<16) |          (@bassPattern3 -@instrArray) 
              long  (8<<28) | (9<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (8<<28) | (0<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  (8<<28) | (2<<24) | (3<<16) |          (@bassPattern1 -@instrArray) 
              long  (9<<28) | (10<<24)| (3<<16) |          (@bassPattern2 -@instrArray)
              long  (8<<28) | (0<<24) | (3<<16) |          (@bassPattern3 -@instrArray)
              long  0

patternSeqMainMelody1
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (5<<28) | (2<<24) | (2<<16) |          (@chorus1Voice1 -@instrArray) 
              long  (5<<28) | (2<<24) | (2<<16) |          (@chorus2Voice1 -@instrArray) 
              long  (6<<28) | (2<<24) | (5<<16) |          (@chorus3Voice1 -@instrArray)
              long  (6<<28) | (2<<24) | (5<<16) |          (@chorus3Voice1 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge1Voice1 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge2Voice1 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge3Voice1 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge3Voice1 -@instrArray)
              long  0 

patternSeqMainMelody2
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (5<<28) | (2<<24) | (2<<16) |          (@chorus1Voice2 -@instrArray) 
              long  (5<<28) | (2<<24) | (2<<16) |          (@chorus2Voice2 -@instrArray) 
              long  (7<<28) | (7<<24) | (5<<16) |          (@chorus3Voice2 -@instrArray)
              long  (7<<28) | (7<<24) | (5<<16) |          (@chorus3Voice2 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge1Voice2 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge2Voice2 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge3Voice2 -@instrArray)
              long  (5<<28) | (2<<24) | (2<<16) |          (@bridge3Voice2 -@instrArray)
              long  0 

patternSeqChord1
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (10<<24)| (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (0<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (10<<24)| (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (0<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (10<<24)| (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (10<<24)| (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (1<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (1<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  0
              

patternSeqChord2
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (7<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (4<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (5<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (7<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  0

patternSeqChord3
              '      Octave |   Note  |  noteOn | noteOff | patternPointer
              '      -----------------------------------------------------
              long  (7<<28) | (9<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (5<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (7<<28) | (7<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (7<<28) | (9<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (5<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (7<<28) | (7<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (7<<28) | (9<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (9<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (7<<28) | (5<<24) | (4<<16) |          (@notePattern2 -@instrArray) 
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (10<<24)| (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray) 
              long  (6<<28) | (9<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  (6<<28) | (10<<24)| (4<<16) |          (@notePattern1 -@instrArray) 
              long  (5<<28) | (2<<24) | (4<<16) |          (@notePattern1 -@instrArray)
              long  0

patternSeqTriangle
              long  (150 <<20) | 32768| (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray)  
              long  0          |  0   | (0<<16) |          (@drumPattern1 -@instrArray) 
              long  0

patternSeqNoise
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  0          |  0   | (1<<16) |          (@hiHatPattern1 -@instrArray) 
              long  -1

dat
bassPattern1  byte ((12 + 0 )<<3) | 3
              byte ((12 + 0 )<<3) | 1 
              byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 0 )<<3) | 1 
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 0 )<<3) | 1  
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 0 )<<3) | 1 
              byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 1 
              byte 0

bassPattern2  byte ((12 + 0 )<<3) | 3
              byte ((12 + 0 )<<3) | 1 
              byte ((12 + 12)<<3) | 1
              byte ((12 - 12)<<3) | 1
              byte ((12 + 12)<<3) | 3
              byte ((12 - 12)<<3) | 1 
              byte 0
              
bassPattern3  byte ((12 + 0 )<<3) | 3
              byte ((12 + 12)<<3) | 1  
              byte ((12 - 12)<<3) | 3
              byte ((12 + 0 )<<3) | 1 
              byte ((12 + 12)<<3) | 1
              byte ((12 + 0 )<<3) | 1 
              byte 0
'───────────────────────────────────────────────────────────  
chorus1Voice1 byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 - 1 )<<3) | 7
              byte ((12 + 14)<<3) | 3
              byte ((12 - 7 )<<3) | 1
              byte ((12 - 2 )<<3) | 1
              byte ((12 + 5 )<<3) | 1
              byte ((12 - 5 )<<3) | 1
              byte ((12 + 7 )<<3) | 1
              byte ((12 - 0 )<<3) | 5
              byte ((12 - 7 )<<3) | 5
              byte ((12 + 7 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 + 5 )<<3) | 7
              byte ((12 + 15)<<3) | 3
              byte 0
                          
chorus2Voice1 byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 - 1 )<<3) | 7
              byte ((12 + 14)<<3) | 3
              byte ((12 - 7 )<<3) | 1
              byte ((12 - 2 )<<3) | 1 
              byte ((12 + 7 )<<3) | 5
              byte ((12 - 0 )<<3) | 5
              byte ((12 - 7 )<<3) | 5
              byte ((12 + 7 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 - 7 )<<3) | 3
              byte ((12 + 15)<<3) | 7
              byte 0

chorus3Voice1 byte ((12 + 13)<<3) | 3
              byte ((12 + 0 )<<3) | 7               
              byte ((12 + 7 )<<3) | 5 
              byte ((12 - 1 )<<3) | 1 
              byte ((12 + 1 )<<3) | 1
              byte ((12 - 1 )<<3) | 1
              byte ((12 - 3 )<<3) | 7
              byte ((12 + 4 )<<3) | 3 
              byte ((12 + 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 3  
              byte ((12 - 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 3
              byte ((12 - 0 )<<3) | 3 
              byte ((12 + 2 )<<3) | 1
              byte ((12 - 1 )<<3) | 3  
              byte ((12 - 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 3
              byte 0

bridge1Voice1 byte ((12 - 1)<<3)  | 5
              byte ((12 + 3)<<3)  | 5
              byte ((12 + 6)<<3)  | 3
              byte ((12 - 1)<<3)  | 7
              byte ((12 - 4)<<3)  | 3
              byte ((12 - 3)<<3)  | 3
              byte ((12 - 1)<<3)  | 5
              byte ((12 + 3)<<3)  | 5
              byte ((12 + 6)<<3)  | 3
              byte ((12 - 1)<<3)  | 7
              byte ((12 - 7)<<3)  | 7
              byte 0

bridge2Voice1 byte ((12 - 1)<<3)  | 5
              byte ((12 + 3)<<3)  | 5
              byte ((12 + 6)<<3)  | 3
              byte ((12 - 1)<<3)  | 7
              byte ((12 - 4)<<3)  | 3
              byte ((12 - 3)<<3)  | 3
              byte ((12 + 2)<<3)  | 5
              byte ((12 + 3)<<3)  | 5
              byte ((12 + 3)<<3)  | 3
              byte ((12 - 1)<<3)  | 7
              byte ((12 + 2)<<3)  | 3
              byte ((12 + 2)<<3)  | 3
              byte 0

bridge3Voice1 byte ((12 + 0 )<<3) | 1
              byte ((12 + 0 )<<3) | 1
              byte ((12 - 12)<<3) | 1
              byte ((12 + 0 )<<3) | 7 
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 1
              byte ((12 - 4 )<<3) | 3
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 3 )<<3) | 1
              byte ((12 + 1 )<<3) | 5
              byte ((12 - 2 )<<3) | 3
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 4 )<<3) | 1
              byte ((12 + 1 )<<3) | 5
              byte 0
                         
'───────────────────────────────────────────────────────────  
chorus1Voice2 byte ((12 - 5 )<<3) | 1
              byte ((12 + 0 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 - 0 )<<3) | 7
              byte ((12 + 14)<<3) | 3
              byte ((12 - 10)<<3) | 1
              byte ((12 - 5 )<<3) | 1
              byte ((12 + 5 )<<3) | 1
              byte ((12 - 0 )<<3) | 1
              byte ((12 + 8 )<<3) | 1
              byte ((12 - 5 )<<3) | 5
              byte ((12 - 3 )<<3) | 5
              byte ((12 + 8 )<<3) | 3
              byte ((12 - 3 )<<3) | 3
              byte ((12 + 5 )<<3) | 7
              byte ((12 + 15)<<3) | 3
              byte 0
                          
chorus2Voice2 byte ((12 - 5 )<<3) | 1
              byte ((12 + 0 )<<3) | 3
              byte ((12 - 2 )<<3) | 3
              byte ((12 - 0 )<<3) | 7
              byte ((12 + 14)<<3) | 3
              byte ((12 - 10)<<3) | 1
              byte ((12 - 5 )<<3) | 1
              byte ((12 + 5 )<<3) | 1
              byte ((12 - 0 )<<3) | 1
              byte ((12 + 8 )<<3) | 1
              byte ((12 - 0 )<<3) | 5
              byte ((12 - 8 )<<3) | 5
              byte ((12 + 8 )<<3) | 3
              byte ((12 - 3 )<<3) | 3
              byte ((12 - 5 )<<3) | 7
              byte ((12 + 15)<<3) | 3
              byte 0

chorus3Voice2 byte ((12 + 13)<<3) | 3
              byte ((12 + 2 )<<3) | 7               
              byte ((12 + 7 )<<3) | 5 
              byte ((12 - 1 )<<3) | 1 
              byte ((12 + 1 )<<3) | 1
              byte ((12 - 1 )<<3) | 1
              byte ((12 - 3 )<<3) | 7
              byte ((12 + 4 )<<3) | 3 
              byte ((12 + 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 3  
              byte ((12 - 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 5
              byte ((12 - 0 )<<3) | 3 
              byte ((12 + 2 )<<3) | 1
              byte ((12 - 1 )<<3) | 3  
              byte ((12 - 0 )<<3) | 1
              byte ((12 - 1 )<<3) | 1
              byte 0
              
bridge1Voice2 byte ((12 - 10)<<3) | 5
              byte ((12 + 9 )<<3) | 5
              byte ((12 + 3 )<<3) | 3
              byte ((12 - 2 )<<3) | 7
              byte ((12 - 5 )<<3) | 3
              byte ((12 - 4 )<<3) | 3
              byte ((12 - 1 )<<3) | 5
              byte ((12 + 3 )<<3) | 5
              byte ((12 + 6 )<<3) | 3
              byte ((12 + 1 )<<3) | 7
              byte ((12 - 5 )<<3) | 7
              byte 0

bridge2Voice2 byte ((12 - 10)<<3) | 5
              byte ((12 + 9 )<<3) | 5
              byte ((12 + 3 )<<3) | 3
              byte ((12 - 2 )<<3) | 7
              byte ((12 - 5 )<<3) | 3
              byte ((12 - 4 )<<3) | 3
              byte ((12 + 2 )<<3) | 5
              byte ((12 + 3 )<<3) | 5
              byte ((12 + 6 )<<3) | 3
              byte ((12 - 3 )<<3) | 7
              byte ((12 + 1 )<<3) | 3
              byte ((12 + 7 )<<3) | 3  
              byte 0
              
bridge3Voice2 byte ((12 - 5 )<<3) | 1
              byte ((12 + 0 )<<3) | 1
              byte ((12 - 12)<<3) | 1
              byte ((12 + 0 )<<3) | 7 
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 1
              byte ((12 - 4 )<<3) | 3
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 4 )<<3) | 1
              byte ((12 + 1 )<<3) | 5
              byte ((12 - 3 )<<3) | 3
              byte ((12 + 0 )<<3) | 3
              byte ((12 + 4 )<<3) | 1
              byte ((12 + 1 )<<3) | 5
              byte 0
                      
'───────────────────────────────────────────────────────────                   
drumPattern1  byte (0<<3) | 7 
              byte (0<<3) | 7 
              byte (0<<3) | 3 
              byte (0<<3) | 3
              byte (0<<3) | 7 
              byte (0<<3) | 7 
              byte (0<<3) | 7 
              byte (0<<3) | 3 
              byte (0<<3) | 3
              byte (0<<3) | 3 
              byte (1<<3) | 1
              byte (0<<3) | 1
              byte 0

hiHatPattern1 byte (26<<3) | 3 
              byte (24<<3) | 3 
              byte (27<<3) | 3 
              byte (24<<3) | 3 
              byte (26<<3) | 1 
              byte (26<<3) | 1
              byte (24<<3) | 3 
              byte (27<<3) | 3 
              byte (24<<3) | 3  
              byte (26<<3) | 3 
              byte (24<<3) | 3 
              byte (27<<3) | 3 
              byte (24<<3) | 3  
              byte (26<<3) | 0 
              byte (26<<3) | 0 
              byte (26<<3) | 0
              byte (26<<3) | 0
              byte (24<<3) | 3 
              byte (27<<3) | 3 
              byte (27<<3) | 1
              byte (27<<3) | 1
              byte 0

notePattern1  byte ((12 + 0 )<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte 0

notePattern2  byte ((12 + 0 )<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte ((12 + 13)<<3) | 7
              byte 0

dat
bass          long  $4+1,  $0112_0100 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $5000_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $0000_0120 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  $4+3, -$0000_8000 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  (50<<4) + $8+0, -$0000_0000  ' modify ch1_freq
              long  $4+1,  (-$0003_81ff) | $000
              long  $0+0, -(1<<3)     ' jump -5 steps

pluck         long  $4+1,  $0810_2007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $8800_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $0000_1800 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  $4+1, -$0008_1000 | %1  
              long  (96<<4) + $8+0, -$0000_0000  
              long  $4+1,   $0590_2005
              long  $4+1,  -$0003_1000 | %1 
              long  $0+0, -(4<<3)      
              
chord         long  $4+1,  $0000_1007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $0c00_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $0001_3000 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  (80 <<4) +$8+0, -$0000_0121 ' modify ch1_freq 
              long  (160<<4) +$8+0,  $0000_0121 ' modify ch1_freq
              long  (160<<4) +$8+0, -$0000_0121 ' modify ch1_freq  
              long  $0+0, -(3<<3)     

mainLead      long  $0+0, +(2<<3) 
              long  (100000<<4) +$8+0,-$0000_4200
              long  (100000<<4) +$8+0, $0000_1200
              long  $4+1,  $0029_0007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $4800_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $0000_0102 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  (30<<4) +$4+3,  $0001_0000 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  $4+1,   -$0001_0000 | %1 
              long  (100<<4) +$8+0,  -$0000_0000  ' modify ch1_freq
              long  $4+3,    $0002_0000 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  $4+1,   -$0000_1300 | %1
              long  (30<<4) +$8+0, -$0000_0811 ' modify ch1_freq 
              long  (60<<4) +$8+0,  $0000_0811 ' modify ch1_freq
              long  (60<<4) +$8+0, -$0000_0811 ' modify ch1_freq  
              long  $0+0, -(3<<3)     ' jump -5 steps

kick          long  $4+1,  $0780_0007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $9000_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $ffff_f100 ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  (1<<4) + $8+0,  $6300_8000
              long  $4+0,  $ff4_0000  
              long  (1<<4)  + $8+0, -$00f1_6991
              long  (11<<4) + $8+0, -$0003_4791
              long  (15<<4) + $8+0, -$0001_5591              
              long  $4+1,   -$0004_b000 | %1  
              long  (78<<4) + $8+0, -$0000_0600 
              long  $4+1,   -$0002_0000 | %1 
              long  (100<<4) + $8+0, -$0000_0200
              long  (80<<4) + $8+0,  $0000_0021
              long  $0+0, -(3<<3)     ' jump -3 steps
       
hiHatOpen     long  $0+0, +(2<<3)
              long  $0+0, +(7<<3)
              long  $0+0, +(12<<3) 
              long  $4+0,  $8000_0000 ' ch1_freq  - bit 31-0:  Signed frequency 
              long  $4+1,  $08a0_0007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $9000_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $46b7_f757
              long  $4+1,  -$003_2000 | %1 
              long  $0+0, -(1<<3)    ' jump -5 steps

hiHatClosed   long  $4+0,  $8000_0000 ' ch1_freq  - bit 31-0:  Signed frequency 
              long  $4+1,  $08a0_0007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $d000_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $46b7_f757   
              long  $4+1,  -$020_5000 | %1 
              long  $0+0, -(1<<3)    ' jump -5 steps

clap          long  $4+0,  $3800_0000 ' ch1_freq  - bit 31-0:  Signed frequency 
              long  $4+1,  $01a0_0007 ' ch1_ASD   - bit 31-5:  Attack/Decay/AM rate      bit 4-0:  Amplitude modulation amount
              long  $4+2,  $a000_0000 ' ch1_vol   - bit 31-27: Sustain level
              long  $4+3,  $4ebf_278f ' ch1_mod   - bit 31-10: Waveform modulation rate  bit 9-0: Set fixed waveform
              long  (1<<4) +$8+0,  $0000_0000 ' modify     
              long  $4+1,  -$0004_7000 | %1 
              long  $0+0, -(1<<3)    ' jump -5 steps
