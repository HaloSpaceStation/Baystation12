SET z_levels=4
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../maps/Forward_unto_dawn-%%i.dmm.backup ../../maps/Forward_unto_dawn-%%i.dmm ../../maps/Forward_unto_dawn-%%i.dmm
)

pause