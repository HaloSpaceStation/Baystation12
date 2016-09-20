SET z_levels=4
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy Forward_unto_dawn-%%i.dmm Forward_unto_dawn-%%i.dmm.backup
)

pause
