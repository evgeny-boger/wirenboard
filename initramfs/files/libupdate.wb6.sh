#!/bin/bash

POWER_BUTTON_GPIO=138
PWM_BUZZER=0

# 3 kHz, 2% volume
DUTY_CYCLE=3333
PERIOD=333333

buzzer_init() {
    echo $PWM_BUZZER > /sys/class/pwm/pwmchip0/export 2>/dev/null || true
    sleep 1 # make PWM settle, presence of these files is not enough

    echo $DUTY_CYCLE > /sys/class/pwm/pwmchip0/pwm${PWM_BUZZER}/duty_cycle
    echo $PERIOD > /sys/class/pwm/pwmchip0/pwm${PWM_BUZZER}/period
}

buzzer_on() {
    echo 1 > /sys/class/pwm/pwmchip0/pwm${PWM_BUZZER}/enable
}

buzzer_off() {
    echo 0 > /sys/class/pwm/pwmchip0/pwm${PWM_BUZZER}/enable
}

button_init() {
    echo $POWER_BUTTON_GPIO > /sys/class/gpio/export 2>/dev/null || true
}

button_read() {
    cat /sys/class/gpio/gpio${POWER_BUTTON_GPIO}/value
}

button_up() {
    [ `button_read` == 0 ]
}

button_down() {
    [ `button_read` == 1 ]
}
