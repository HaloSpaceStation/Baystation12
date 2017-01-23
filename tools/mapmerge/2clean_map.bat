SET z_levels=5
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/unsc_cruiser-%%i.dmm.backup ../../maps/unsc_cruiser-%%i.dmm ../../maps/unsc_cruiser-%%i.dmm
)

pause