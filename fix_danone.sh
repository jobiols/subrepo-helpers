#!/bin/bash
# Reestructura los repositorios de danone_v14 
# el principal problema es que los repos publicos de localizacion bajan como privados y travis no los puede bajar
# como problema secundario los repositorios estan resprolijos
# hay que bajar la rama que se quiere corregir en tmp/danone_v14

cd ~/tmp/danone_v14

# eliminar el .gitmodules
rm -r .gitmodules

#quitar de .git/config todas las referencias a los submodulos
sed -i '14,$d' .git/config
#vim .git/config

# poner los cambios en staging
git add .

# eliminar los directorios de los submodulos
git rm --cached account-financial-tools
git rm --cached account-payment
git rm --cached odoo-argentina
git rm --cached odoo-argentina-ee
git rm --cached reporting-engine
git rm --cached server-backend
git rm --cached server-tools
git rm --cached website

sudo rm -r account-financial-tools
sudo rm -r account-payment
sudo rm -r odoo-argentina
sudo rm -r odoo-argentina-ee
sudo rm -r reporting-engine
sudo rm -r server-backend
sudo rm -r server-tools
sudo rm -r website

# commitear el trabajo hecho
git commit -m"[REM] eliminar todos los submodulos"

# agregar los submodulos incluyendolos en un directorio agrupados por autor y protocolo https
git submodule add -b 14.0 https://github.com/quilsoft-org/account-financial-tools.git sub-loca
git submodule add -b 14.0 https://github.com/quilsoft-org/account-payment.git sub-loca
git submodule add -b 14.0 https://github.com/quilsoft-org/odoo-argentina.git sub-loca
git submodule add -b 14.0 https://github.com/quilsoft-org/odoo-argentina-ee.git sub-loca
git submodule add -b 14.0 https://github.com/OCA/reporting-engine.git sub-oca
git submodule add -b 14.0 https://github.com/OCA/server-backend.git sub-oca
git submodule add -b 14.0 https://github.com/OCA/website.git sub-oca

# poner en staging
git add .

# commitear el trabajo
git commit -m"[ADD] agregar todos los submodulos categorizadso y con protocolo https"

