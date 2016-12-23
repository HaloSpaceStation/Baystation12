SET z_levels=4
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/unsc_frigate-%%i.dmm.backup ../../maps/unsc_frigate-%%i.dmm ../../maps/unsc_frigate-%%i.dmm
)

pause