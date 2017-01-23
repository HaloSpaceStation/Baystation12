SET z_levels=5
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy unsc_cruiser-%%i.dmm unsc_cruiser-%%i.dmm.backup
)

pause
