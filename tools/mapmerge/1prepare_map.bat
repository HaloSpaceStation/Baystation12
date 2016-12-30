SET z_levels=4
cd ../../maps

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy unsc_frigate-%%i.dmm unsc_frigate-%%i.dmm.backup
)

pause
