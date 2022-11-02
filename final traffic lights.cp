#line 1 "D:/university/AASTMT/SEMESTER 10 FINALLY/micro/final exam practical/final traffic lights.c"
#line 10 "D:/university/AASTMT/SEMESTER 10 FINALLY/micro/final exam practical/final traffic lights.c"
unsigned long milliSecs = 0;
void Interrupt(){
 if (TMR0IF_bit){
 TMR0IF_bit= 0;
 TMR0=6;
 milliSecs++;
 }
}


const int segmenthex[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x3F};
const int reverse[] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0};
int secs = 0;



void main_seq() {
loop
if (secs < 6) {
  PORTC.F0 = 1;
  PORTC.F2 = 0;
  PORTC.F1 = 0;

 PORTB = segmenthex[reverse[(secs-5)%10]];
 }
 }
 if (secs >= 9 && secs < 15) {
  PORTC.F0 = 0;
  PORTC.F2 = 0;
  PORTC.F1 = 1;


 PORTB = segmenthex[abs(reverse[(secs-6)%10])];
 }

 if (secs >=15 ) {
  PORTC.F0 = 0;
  PORTC.F2 = 1;
  PORTC.F1 = 0;

 PORTB = segmenthex[reverse[(secs-13)%10]];

 }
else goto loop
}
void main() {

 OPTION_REG = 0x82;
 TMR0 = 6;
 INTCON = 0xA0;

 TRISB = 0;
 PORTB = segmenthex[0];

 TRISC = 0;
 PORTC = 0;

 while(1) {
 secs = milliSecs/1000;

 main_seq();
 }
 if (milliSecs >= 15000) {
 milliSecs = 0;
 }
 }
