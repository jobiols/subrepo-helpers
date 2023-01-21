#!/bin/bash
# Este baja el repositorio tech (borrandolo si ya existe) y lo modifica para
# ponerle los subrepositorios de la v15
# ATENCION Este script hay que correrlo ANTES de correr la migracion en SH


cd ~/tmp
sudo rm -r tech

# Bajar el repositorio completo con todos los submodulos
git clone --recurse-submodules --branch 13.0 git@github.com:wavesinmovement/tech.git
cd tech

# eliminar el .gitmodules
rm -r .gitmodules

#quitar de .git/config todas las referencias a los submodulos
sed -i '14,$d' .git/config
#vim .git/config

# poner los cambios en staging
git add .

# eliminar los directorios de los submodulos
git rm --cached external-modules
git rm --cached waves-modules
git rm --cached ingadhoc/account-financial-tools
git rm --cached ingadhoc/account-payment
git rm --cached ingadhoc/aeroo_reports
git rm --cached ingadhoc/odoo-argentina
git rm --cached ingadhoc/odoo-argentina-ee
sudo rm -r external-modules
sudo rm -r ingadhoc
sudo rm -r waves-modules

# commitear el trabajo hecho
git commit -m"[REM] subrepos v14"

# agregar los submodulos de la version 15
# aca no se porque no se pueden agregar con el mismo path por eso pongo ingadhoc1
git submodule add -b 15.0 git@github.com:wavesinmovement/waves-modules.git waves/waves-modules
git submodule add -b 15.0 git@github.com:ingadhoc/account-financial-tools.git ingadhoc1/account-financial-tools
git submodule add -b 15.0 git@github.com:quilsoft-org/account-payment.git ingadhoc1/account-payment
git submodule add -b 15.0 git@github.com:ingadhoc/odoo-argentina.git ingadhoc1/odoo-argentina
git submodule add -b 15.0 git@github.com:ingadhoc/odoo-argentina-ee.git ingadhoc1/odoo-argentina-ee
git submodule add -b 15.0 git@github.com:ingadhoc/aeroo_reports.git ingadhoc1/aeroo_reports
git submodule add -b 15.0 git@github.com:wavesinmovement/external-modules.git externals/external-modules

# poner en staging
git add .

# commitear el trabajo
git commit -m"[ADD] subrepos v15"
