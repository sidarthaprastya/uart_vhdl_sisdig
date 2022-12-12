# Panduan UART untuk Praktikum Sistem Digital Semester 1 - 2022/2023

References: https://www.pantechsolutions.net/vhdl-code-for-uart-serial-communication

## Hardware:
- FPGA EP4CE6E22C8 (Altera Cyclone IV)
- USB/TTL (3.3V)
- PC (yang digunakan: Windows)

## Software:
- Quartus II v9.1Sp2 Web Edition

## Cara menjalankan
- Buka project di Quartus
- Lakukan full compile terhadap project
- Pastikan pin assignment telah diatur
- Compile ulang
- Upload ke FPGA dengan Programmer (USB-BLASTER)

## Konfigurasi Serial Monitor
- Lihat COM yang terhubung melalui device manager
- Buka aplikasi Serial Monitor (bisa PuTTY, Arduino IDE Serial Monitor, dll.)
- Set komunikasi Serial dengan COM yang terhubung dan Baud Rate 9600
- Pastikan Stop Bit "1" dan "no line ending"
- Pengiriman serial hanya per 1 karakter.

## Ingin Mengirim lebih dari 1 karakter???
- Program, jalankan, dan hubungkan FPGA terlebih dahulu.
- Pastikan Serial Monitor atau apapun tidak terhubung ke COM Port yang dituju
- Silakan ubah COM PORT pada uart.py sesuai dengan COM yang tersedia
```
ser = serial.Serial('COM7', 9600, bytesize=serial.EIGHTBITS,
        parity=serial.PARITY_NONE,
        stopbits=serial.STOPBITS_ONE,
        timeout=None)
```
- Jalankan uart.py
```
python uart.py
```
- Masukkan input string dan ENTER
- Jika benar, hasil output akan sama dengan input.

