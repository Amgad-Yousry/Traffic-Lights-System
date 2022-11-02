
#define RED PORTC.F0
#define GREEN PORTC.F1
#define YELLOW PORTC.F2


//timer
unsigned long milliSecs = 0;
void Interrupt(){
  if (TMR0IF_bit){
    TMR0IF_bit= 0;
    TMR0=6;
    milliSecs++;
  }
}

//variables
const int segmenthex[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F, 0x3F};
const int reverse[] = {9, 8, 7, 6, 5, 4, 3, 2, 1, 0}; //segment "reverse" look-up array
int secs = 0;

//int abs(int a);

void main_seq()   {
init loop
if (secs < 6) {
    RED= 1;
    YELLOW= 0;
    GREEN= 0;

    PORTB = segmenthex[abs(reverse[(secs-6)%10])];
  }
  }
  if (secs >= 9 && secs < 15) {
    RED= 0;
    YELLOW= 0;
    GREEN= 1;


    PORTB = segmenthex[abs(reverse[(secs-6)%10])];
  }

  if (secs >=15 ) {
    RED= 0;
    YELLOW= 1;
    GREEN= 0;

    PORTB = segmenthex[reverse[secs%10]];
    
  }
}
void main() {
  //timer initialization
  OPTION_REG = 0x82;
  TMR0       = 6;
  INTCON     = 0xA0;
  //portenableing
  TRISB = 0;
  PORTB = segmenthex[0];

  TRISC = 0;
  PORTC = 0;

  while(1) {
            secs = milliSecs/1000;

              }
              if (milliSecs >= 16000) {
                  milliSecs = 0;
              }
                main_seq();
     }