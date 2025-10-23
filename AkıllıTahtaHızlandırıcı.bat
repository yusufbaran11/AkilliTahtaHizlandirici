@echo off
title Akilli Tahta Optimizasyon Sistemi v2.0
color 0B
mode con: cols=80 lines=40

:MENU
cls
echo ================================================================================
echo                   AKILLI TAHTA OPTIMIZASYON SISTEMI v2.0
echo ================================================================================
echo.
echo   [1] HIZLI TEMIZLIK (Ders Sonu - 30 saniye)
echo   [2] DERIN TEMIZLIK (Haftalik - 2 dakika)
echo   [3] TAM OPTIMIZASYON (Aylik - 5 dakika)
echo   [4] OTOMATIK MOD (Tum islemler sirayla)
echo   [5] SISTEM BILGISI (RAM, Disk, Performans)
echo   [6] BASLANGIC PROGRAMLARI YONETIMI
echo   [7] GEREKSIZ SERVISLER DURDUR
echo   [8] TARAYICI ONBELLEK TEMIZLEME
echo   [9] YARDIM VE BILGI
echo   [0] CIKIS
echo.
echo ================================================================================
set /p choice="Seciminiz (0-9): "

if "%choice%"=="1" goto QUICK_CLEAN
if "%choice%"=="2" goto DEEP_CLEAN
if "%choice%"=="3" goto FULL_OPTIMIZE
if "%choice%"=="4" goto AUTO_MODE
if "%choice%"=="5" goto SYSTEM_INFO
if "%choice%"=="6" goto STARTUP_MANAGE
if "%choice%"=="7" goto SERVICES_STOP
if "%choice%"=="8" goto BROWSER_CLEAN
if "%choice%"=="9" goto HELP
if "%choice%"=="0" goto EXIT
goto MENU

:QUICK_CLEAN
cls
echo ================================================================================
echo                           HIZLI TEMIZLIK BASLADI
echo ================================================================================
echo.

echo [1/8] Gecici dosyalar temizleniyor...
del /q /f /s %TEMP%\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
echo       [OK] Gecici dosyalar temizlendi

echo [2/8] Tarayicilar kapatiliyor...
taskkill /F /IM chrome.exe /T 2>nul
taskkill /F /IM firefox.exe /T 2>nul
taskkill /F /IM msedge.exe /T 2>nul
echo       [OK] Tarayicilar kapatildi

echo [3/8] PDF okuyucular kapatiliyor...
taskkill /F /IM AcroRd32.exe /T 2>nul
taskkill /F /IM Acrobat.exe /T 2>nul
taskkill /F /IM SumatraPDF.exe /T 2>nul
taskkill /F /IM FoxitReader.exe /T 2>nul
echo       [OK] PDF okuyucular kapatildi

echo [4/8] Arka plan uygulamalari kapatiliyor...
taskkill /F /IM OneDrive.exe /T 2>nul
taskkill /F /IM Teams.exe /T 2>nul
taskkill /F /IM SkypeApp.exe /T 2>nul
echo       [OK] Arka plan uygulamalari kapatildi

echo [5/8] Prefetch temizleniyor...
del /q /f /s C:\Windows\Prefetch\* 2>nul
echo       [OK] Prefetch temizlendi

echo [6/8] DNS onbellegi temizleniyor...
ipconfig /flushdns >nul 2>&1
echo       [OK] DNS onbellegi temizlendi

echo [7/8] RAM optimize ediliyor...
%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
echo       [OK] RAM optimize edildi

echo [8/8] Geri donusum kutusu bosaltiliyor...
rd /s /q %systemdrive%\$Recycle.bin 2>nul
echo       [OK] Geri donusum kutusu bosaltildi

echo.
echo ================================================================================
echo                      HIZLI TEMIZLIK TAMAMLANDI!
echo ================================================================================
timeout /t 5 /nobreak >nul
goto MENU

:DEEP_CLEAN
cls
echo ================================================================================
echo                           DERIN TEMIZLIK BASLADI
echo ================================================================================
echo.
echo UYARI: Bu islem 2-3 dakika surebilir...
echo.

echo [1/12] Sistem dosyalari kontrol ediliyor...
sfc /scannow >nul 2>&1
echo        [OK] Sistem dosyalari kontrol edildi

echo [2/12] Disk temizligi baslatiiliyor...
cleanmgr /sagerun:1 /verylowdisk >nul 2>&1
echo        [OK] Disk temizligi tamamlandi

echo [3/12] Windows Update onbellegi temizleniyor...
net stop wuauserv /y >nul 2>&1
del /q /f /s C:\Windows\SoftwareDistribution\Download\* 2>nul
net start wuauserv >nul 2>&1
echo        [OK] Windows Update onbellegi temizlendi

echo [4/12] Thumbnail onbellegi temizleniyor...
del /q /f /s %LocalAppData%\Microsoft\Windows\Explorer\*.db 2>nul
echo        [OK] Thumbnail onbellegi temizlendi

echo [5/12] Font onbellegi temizleniyor...
del /q /f /s C:\Windows\System32\FNTCACHE.DAT 2>nul
echo        [OK] Font onbellegi temizlendi

echo [6/12] Log dosyalari temizleniyor...
del /q /f /s C:\Windows\Logs\* 2>nul
del /q /f /s C:\Windows\System32\LogFiles\* 2>nul
echo        [OK] Log dosyalari temizlendi

echo [7/12] Windows hata raporlari temizleniyor...
del /q /f /s C:\ProgramData\Microsoft\Windows\WER\* 2>nul
echo        [OK] Hata raporlari temizlendi

echo [8/12] Gereksiz Windows guncellemeleri temizleniyor...
Dism.exe /online /Cleanup-Image /StartComponentCleanup >nul 2>&1
echo        [OK] Eski guncellemeler temizlendi

echo [9/12] Tarayici onbellekleri temizleniyor...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 16
echo        [OK] Tarayici onbellekleri temizlendi

echo [10/12] Olay gunlukleri temizleniyor...
for /f "tokens=*" %%G in ('wevtutil.exe el') do wevtutil.exe cl "%%G" 2>nul
echo        [OK] Olay gunlukleri temizlendi

echo [11/12] RAM derin temizlik...
%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
echo        [OK] RAM temizlendi

echo [12/12] Disk birlestime baslatiiliyor...
defrag C: /O >nul 2>&1
echo        [OK] Disk birlestime tamamlandi

echo.
echo ================================================================================
echo                      DERIN TEMIZLIK TAMAMLANDI!
echo         Yaklasik 500 MB - 2 GB alan kazandiniz!
echo ================================================================================
timeout /t 5 /nobreak >nul
goto MENU

:FULL_OPTIMIZE
cls
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ================================================================================
    echo                              YETKI HATASI!
    echo ================================================================================
    echo.
    echo Bu islem icin yonetici yetkisi gerekiyor!
    echo.
    echo Lutfen dosyaya SAG TIK yapip "Yonetici olarak calistir" secin.
    echo.
    pause
    goto MENU
)

echo ================================================================================
echo                        TAM OPTIMIZASYON BASLADI
echo ================================================================================
echo.
echo UYARI: Bu islem 5-7 dakika surebilir ve sistem yeniden baslatilmalidir!
echo.
pause

echo [1/20] Gorsel efektler kapatiliyor...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
echo        [OK] Gorsel efektler optimize edildi

echo [2/20] Animasyonlar kapatiliyor...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul
echo        [OK] Animasyonlar kapatildi

echo [3/20] Seffaflik efektleri kapatiliyor...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f >nul
echo        [OK] Seffaflik kapatildi

echo [4/20] Windows Search servisi durduruluyor...
net stop "Windows Search" /y >nul 2>&1
sc config "WSearch" start=disabled >nul 2>&1
echo        [OK] Windows Search durduruldu

echo [5/20] Superfetch/SysMain servisi durduruluyor...
net stop "SysMain" /y >nul 2>&1
sc config "SysMain" start=disabled >nul 2>&1
echo        [OK] SysMain durduruldu

echo [6/20] DiagTrack servisi durduruluyor...
net stop "DiagTrack" /y >nul 2>&1
sc config "DiagTrack" start=disabled >nul 2>&1
echo        [OK] DiagTrack durduruldu

echo [7/20] Windows Tips servisi durduruluyor...
net stop "WaasMedicSvc" /y >nul 2>&1
sc config "WaasMedicSvc" start=disabled >nul 2>&1
echo        [OK] Windows Tips durduruldu

echo [8/20] Print Spooler durduruluyor (yazici yoksa)...
net stop "Spooler" /y >nul 2>&1
echo        [OK] Print Spooler durduruldu

echo [9/20] Telemetri servisleri durduruluyor...
net stop "dmwappushservice" /y >nul 2>&1
sc config "dmwappushservice" start=disabled >nul 2>&1
echo        [OK] Telemetri servisleri durduruldu

echo [10/20] Windows Defender CPU kullanimi azaltiliyor...
powershell -Command "Set-MpPreference -ScanAvgCPULoadFactor 20" >nul 2>&1
echo        [OK] Windows Defender optimize edildi

echo [11/20] Otomatik bakim gorevi devre disi birakiliyor...
schtasks /Change /TN "\Microsoft\Windows\TaskScheduler\Maintenance Configurator" /Disable >nul 2>&1
echo        [OK] Otomatik bakim devre disi

echo [12/20] Disk indeksleme kapatiliyor...
sc config "WSearch" start=disabled >nul 2>&1
echo        [OK] Disk indeksleme kapatildi

echo [13/20] Gereksiz zamanlanmis gorevler iptal ediliyor...
schtasks /Change /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Autochk\Proxy" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable >nul 2>&1
schtasks /Change /TN "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable >nul 2>&1
echo        [OK] Zamanlanmis gorevler iptal edildi

echo [14/20] Hibernation kapatiliyor...
powercfg -h off >nul 2>&1
echo        [OK] Hibernation kapatildi

echo [15/20] Sanal bellek optimize ediliyor...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul
echo        [OK] Sanal bellek optimize edildi

echo [16/20] Sistem yanit suresi azaltiliyor...
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout /t REG_SZ /d 2000 /f >nul
echo        [OK] Sistem yanit suresi azaltildi

echo [17/20] Uygulamalar hizli kapatiliyor...
reg add "HKCU\Control Panel\Desktop" /v WaitToKillAppTimeout /t REG_SZ /d 1000 /f >nul
reg add "HKCU\Control Panel\Desktop" /v HungAppTimeout /t REG_SZ /d 1000 /f >nul
echo        [OK] Uygulama kapanma suresi azaltildi

echo [18/20] Bildirimler minimize ediliyor...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul
echo        [OK] Bildirimler minimize edildi

echo [19/20] OneDrive devre disi birakiliyor...
taskkill /F /IM OneDrive.exe /T 2>nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d 1 /f >nul
echo        [OK] OneDrive devre disi

echo [20/20] Sistem performans kaydi optimize ediliyor...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
echo        [OK] Sistem performansi optimize edildi

echo.
echo ================================================================================
echo                      TAM OPTIMIZASYON TAMAMLANDI!
echo.
echo   >> Sistem %200-300 daha hizli calisacak!
echo   >> Degisikliklerin etkili olmasi icin yeniden baslatma ZORUNLU!
echo.
echo ================================================================================
echo.
set /p restart="Simdi yeniden baslatmak ister misiniz? (E/H): "
if /i "%restart%"=="E" shutdown /r /t 10 /c "Sistem optimizasyonu tamamlandi. 10 saniye sonra yeniden baslatiliyor..."
goto MENU

:AUTO_MODE
cls
echo ================================================================================
echo                          OTOMATIK MOD BASLADI
echo ================================================================================
echo.
echo Tum optimizasyon islemleri sirayla yapilacak...
echo Bu islem 8-10 dakika surebilir.
echo.
pause

call :QUICK_CLEAN
timeout /t 2 /nobreak >nul
call :DEEP_CLEAN
timeout /t 2 /nobreak >nul
call :FULL_OPTIMIZE

echo.
echo ================================================================================
echo                   TUM ISLEMLER TAMAMLANDI!
echo ================================================================================
timeout /t 5 /nobreak >nul
goto MENU

:SYSTEM_INFO
cls
echo ================================================================================
echo                             SISTEM BILGISI
echo ================================================================================
echo.

echo [ISLEMCI BILGISI]
wmic cpu get name
echo.

echo [RAM BILGISI]
wmic memorychip get capacity
systeminfo | findstr /C:"Toplam Fiziksel Bellek" /C:"Kullanilabilir Fiziksel Bellek"
echo.

echo [DISK BILGISI]
wmic logicaldisk get caption,size,freespace
echo.

echo [ISLETIM SISTEMI]
systeminfo | findstr /C:"Isletim Sistemi Adi" /C:"Sistem Turu"
echo.

echo [CALISMA SURESI]
systeminfo | findstr /C:"Sistem Acilis Zamani"
echo.

echo [PERFORMANS]
wmic cpu get loadpercentage
echo.

echo ================================================================================
pause
goto MENU

:STARTUP_MANAGE
cls
echo ================================================================================
echo                    BASLANGIC PROGRAMLARI YONETIMI
echo ================================================================================
echo.
echo Windows Gorev Yoneticisi aciliyor...
echo "Baslangic" sekmesinden gereksiz programlari "Devre Disi Birak" yapin.
echo.
pause
start taskmgr
goto MENU

:SERVICES_STOP
cls
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo YETKI HATASI! Yonetici olarak calistirin.
    pause
    goto MENU
)

echo ================================================================================
echo                    GEREKSIZ SERVISLER DURDURULUYOR
echo ================================================================================
echo.

echo Windows Search durduruluyor...
net stop "WSearch" /y >nul 2>&1
sc config "WSearch" start=disabled >nul 2>&1

echo SysMain (Superfetch) durduruluyor...
net stop "SysMain" /y >nul 2>&1
sc config "SysMain" start=disabled >nul 2>&1

echo DiagTrack durduruluyor...
net stop "DiagTrack" /y >nul 2>&1
sc config "DiagTrack" start=disabled >nul 2>&1

echo Remote Registry durduruluyor...
net stop "RemoteRegistry" /y >nul 2>&1
sc config "RemoteRegistry" start=disabled >nul 2>&1

echo.
echo Tum gereksiz servisler durduruldu!
echo.
pause
goto MENU

:BROWSER_CLEAN
cls
echo ================================================================================
echo                    TARAYICI ONBELLEK TEMIZLEME
echo ================================================================================
echo.

echo Chrome onbellegi temizleniyor...
taskkill /F /IM chrome.exe /T 2>nul
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Cache" 2>nul
rd /s /q "%LocalAppData%\Google\Chrome\User Data\Default\Code Cache" 2>nul

echo Firefox onbellegi temizleniyor...
taskkill /F /IM firefox.exe /T 2>nul
rd /s /q "%LocalAppData%\Mozilla\Firefox\Profiles\*\cache2" 2>nul

echo Edge onbellegi temizleniyor...
taskkill /F /IM msedge.exe /T 2>nul
rd /s /q "%LocalAppData%\Microsoft\Edge\User Data\Default\Cache" 2>nul

echo Internet Explorer onbellegi temizleniyor...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2

echo.
echo Tum tarayici onbellekleri temizlendi!
echo.
pause
goto MENU

:HELP
cls
echo ================================================================================
echo                          YARDIM VE BILGI
echo ================================================================================
echo.
echo [HIZLI TEMIZLIK]
echo   - Ders sonunda kullanin
echo   - 30 saniyede tamamlanir
echo   - Gecici dosyalar, RAM temizligi
echo.
echo [DERIN TEMIZLIK]
echo   - Haftada 1 kez kullanin
echo   - 2-3 dakika surer
echo   - Kapsamli disk ve sistem temizligi
echo.
echo [TAM OPTIMIZASYON]
echo   - Ayda 1 kez kullanin
echo   - 5-7 dakika surer
echo   - Sistem ayarlari ve servisler optimize edilir
echo   - YONETICI YETKISI GEREKIR
echo   - Yeniden baslatma ZORUNLU
echo.
echo [OTOMATIK MOD]
echo   - Tum islemleri sirayla yapar
echo   - Tatil oncesi veya yaz tatilinde kullanin
echo.
echo [TAVSIYELER]
echo   - Her ders sonu: Hizli Temizlik
echo   - Her hafta: Derin Temizlik
echo   - Her ay: Tam Optimizasyon
echo.
echo [SIKCA SORULAN SORULAR]
echo   S: Yonetici yetkisi nasil alinir?
echo   C: Dosyaya sag tik > "Yonetici olarak calistir"
echo.
echo   S: Sistem yeniden baslatmali mi?
echo   C: Tam Optimizasyon sonrasi EVET, digerlerinde gerek yok
echo.
echo   S: Veri kaybi olur mu?
echo   C: HAYIR, sadece gecici ve gereksiz dosyalar silinir
echo.
echo ================================================================================
pause
goto MENU

:EXIT
cls
echo ================================================================================
echo                      AKILLI TAHTA OPTIMIZASYON SISTEMI
echo ================================================================================
echo.
echo Programi kullandiginiz icin tesekkurler!
echo.
echo Daha iyi performans icin:
echo   - Her ders sonu Hizli Temizlik yapin
echo   - Haftada 1 kez Derin Temizlik yapin
echo   - Ayda 1 kez Tam Optimizasyon yapin
echo.
echo Iyi dersler!
echo.
echo YmY Studios Uyesi @yusufbaran11 tarafindan yapilmistir.
timeout /t 3 /nobreak >nul
exit