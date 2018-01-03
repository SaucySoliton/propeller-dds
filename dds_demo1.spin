
' Simple test program for DDS

' Also includes some minimal setup for 
' enabling the PropScope DAC card. 
'  
' 
'  
' PropScope DAC Info
' MSB  AUX3  P23
'      AUX2  P22
'      AUX1  P21
'      AUX0  P20
'       D19  P19
'       D18  P18
'       D17  P17
' LSB   D16  P16
' 
' CARD  high to disable adc outputs
' OE to 74AHC541 should be low
' P10  high to select dac 
' 
' P11  range  
' 
' To access the Propscope as a serial port in Linux
' echo 13e2 0080 > /sys/bus/usb-serial/drivers/ftdi_sio/new_id
' 
' 
CON
  _clkmode = xtal1 + pll16x
  _XinFREQ = 5_000_000

  pin_DO =  0
  pin_samp = 1
  
  i2cSCL        = 28
'  i2cSDA        = 29



OBJ
  term    : "Parallax Serial Terminal"
  i2cobj  : "Basic_I2C_Driver"
  dds     : "dds_3bit"
  
VAR
  long parameter


PUB main
  term.Start(115200)
  
  ' Setup for PropScope DAC
  i2cobj.Initialize(i2cSCL)
  i2cobj.writeLocation(i2cSCL,$e0, 3 , $3f ) ' output top 2 bits
  i2cobj.writeLocation(i2cSCL,$e0, 1 , $c0 ) ' card select, -2v on
  outa[10]~~
  dira[10]~~   ' enable dac
 
 
 
 
  dds.start(12) ' 3 bit dac with LSB at pin 12

 ' dds.tune(9_450_000)   
'  waitcnt( 80_000_000 + cnt )  
  'dds.tune(4_000_000)
  dds.tune(10_450_000)       
  repeat
      'waitcnt( 80_000_000 + cnt )
      'tune(9_450_000)

     ' waitcnt( 80_000_000 + cnt )
      'tune(10_450_000)
      dds.modulate( 10450000 )
'      waitcnt( 1_000 + cnt )   
      dds.modulate( 10452000 )   ' Modulation from spin is very slow
      
      
  
