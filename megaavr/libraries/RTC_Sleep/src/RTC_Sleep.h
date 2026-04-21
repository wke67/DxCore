#ifndef RTC_SLEEP_H
#define RTC_SLEEP_H

#include <Arduino.h>

void rtc_sleep(unsigned long time);
unsigned long rtc_millis();
void rtc_set_millis(uint32_t newmillis);
void rtc_reset_millis();

#ifdef  MILLIS_USE_TIMERRTC
  #define rtc_sleep_setup() while(0)
  #define rtc_millis        millis
  #define rtc_reset_millis  reset_millis
  #define rtc_set_millis    set_millis
#endif
#endif
