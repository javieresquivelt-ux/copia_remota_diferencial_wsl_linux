# 🚀 Script de Copia Full e Incremental con Exclusiones

Script automatizado de **sincronización completa** vía SSH+RSYNC con exclusiones inteligentes para respaldos de proyectos de desarrollo web.

## 🎯 Objetivo del Proyecto

Crear respaldos **full, incrementales y seguros** de carpetas de proyectos (ejemplo: `/proyectos/www`) hacia servidor remoto (ejemplo: `192.168.100.10`), **excluyendo** carpetas, archivos, entornos y repositorios temporales para optimizar espacio y tiempo (optativo).

## 📋 Requisitos

- **Bash** 5.1+ (`bash --version`)
- **Rsync** 3.1+ (`rsync --version`) 
- **OpenSSH** client (`ssh -V`)
- Acceso SSH sin contraseña al servidor remoto
- Permisos de lectura/escritura en `$ORIGEN` y `$DESTINO_REMOTO`

## 🗂️ Estructura Básica del Entorno

#### LOCAL:/home/usuario/proyectos/wwww **← Origen** 
- carpeta/ ❌ EXCLUIDO
- carpeta2/ ❌ EXCLUIDO
#### REMOTO: usuario@192.168.100.10:/home/usuario/carpeta **← Destino**

## ⚙️ Configuración Paso a Paso

### 1. Configurar SSH sin Contraseña
#### En máquina LOCAL
ssh-keygen -t ed25519 -C "usuario@local"
ssh-copy-id jet@192.168.100.10

### 2. Preparar Servidor Remoto
#### En 192.168.100.10
- sudo apt update && sudo apt install rsync
- mkdir -p /home/usuario/carpeta_bkp **cambiar por carpeta destino**
- chmod 755 /home/usuario/carpeta_bkp **cambiar por carpeta destino**

### 3. Editar Variables del Script
#### Modificar estas líneas:
- SSH_HOST="usuario@192.168.100.10"
- DESTINO_REMOTO="/home/usuario/carpeta_bkp"
- EXCLUIR=("venv/" "node_modules/" "*.git/") **cambiar por exclusiones reales**

### 4. Permisos
- chmod +x respaldo_completo.sh

## 🚀 Uso Diario

- Respaldo completo (por defecto)
    - ./respaldo_completo.sh

- Con log detallado
    - ./respaldo_completo.sh | tee respaldo_$(date +%Y%m%d).log

- Automatizar con crontab (ej: diario 2AM)
 - crontab -e

- 0 2 * * * /ruta/completa/respaldo_completo.sh >> /var/log/respaldos.log 2>&1

## ⚠️ Problemas Frecuentes

| Problema | Solución |
|----------|----------|
| `Permission denied` | `chmod 755 $DESTINO_REMOTO` en remoto |
| `rsync: command not found` | `sudo apt install rsync` en remoto |
| `No route to host` | Verificar IP `192.168.1.26` y firewall |
| `Broken pipe` | Agregar `--timeout=300` a RSYNC_OPTS |
| `Disk quota exceeded` | `df -h` en destino remoto |

## 📚 Recursos Recomendados

- [Documentación Rsync Completa](https://linux.die.net/man/1/rsync)
- [Guía SSH sin Contraseña](https://www.ssh.com/academy/ssh/keygen)
- [Crontab Guru](https://crontab.guru/) - Generador visual

## 👥 Autoría y Comunidad

Este repo forma parte de mi proceso de aprendizaje en desarrollo **fullstack** usando **WSL + Linux + entornos remotos**, y está pensado para compartir con la comunidad (Conquer o quien lo necesite).  

### Si te sirve:

- Puedes abrir **Issues** con dudas o mejoras.
- Puedes hacer **Pull Requests** con mejoras al script, documentación o ejemplos,
- Utiliza Alias para mejorar aún más la experiencia de usuario.

¡Que te sea útil para mejorar tu entorno de desarrollo en Linux y WSL! 🚀

---

![Bash](https://img.shields.io/badge/Bash-5.1%2B-brightgreen?logo=bash&logoColor=white) ![Rsync](https://img.shields.io/badge/Rsync-3.1%2B-blue?logo=linux&logoColor=white) ![SSH](https://img.shields.io/badge/SSH-OpenSSH-purple?logo=openssh&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-Ubuntu%2FDebian-orange?logo=ubuntu&logoColor=white)
