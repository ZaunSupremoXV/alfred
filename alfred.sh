#!/bin/bash
#TEMPLATES MENSAGENS DE AVISO

#resp-inv(){
#
#}

#TEMPLATES MENU

menu-status(){
while : ; do
  resposta=$(
      dialog --stdout               \
             --title 'ALFRED - STATUS'  \
             --menu 'Escolha uma opcao' \
            0 0 0                   \
            1 'Status do DHCP'        \
            2 'Status do APACHE'        \
            3 'Status do FIREWALLD'        \
            0 'Voltar ao menu principal'                )

    [ $? -ne 0 ] && clear && exit

    case "$resposta" in
        1)
            dhcp_status=`ps -ax | grep dbsrv16 | sed -n '1p' | cut -d " " -f22`
            if [ $dhcp_status = "/contabil/dados/log/logservidor.txt" ] 
            then
                dialog --title 'Status' --msgbox 'Online' 5 40
                menu-status
            else
                dialog --title 'Status' --msgbox 'Offline' 5 40
                menu-status
            fi
        ;;
        2)
            apache_status=`ps -ax | grep httpd | sed -n '1p' | cut -d " " -f16`
            if [ $apache_status = "/usr/sbin/httpd" ] 
            then
                dialog --title 'Status' --msgbox 'Online' 5 40
                menu-status
            else
                dialog --title 'Status' --msgbox 'Offline' 5 40
                menu-status
            fi
        ;;
        3)
            firewall_status=`ps -ax | grep firewalld | sed -n '1p' | cut -d " " -f19`
            if [ $firewall_status = "/usr/sbin/firewalld" ] 
            then
                dialog --title 'Status' --msgbox 'Online' 5 40
                menu-status
            else
                dialog --title 'Status' --msgbox 'Offline' 5 40
                menu-status
            fi
        ;;
        0)
            menu-principal
        ;;
        *)
            resp-inv
        ;;
    esac
done
}

menu-parar(){
while : ; do
  resposta=$(
      dialog --stdout               \
             --title 'ALFRED - PARAR'  \
             --menu 'Escolha uma opcao' \
            0 0 0                   \
            1 'Parar DHCP'        \
            2 'Parar APACHE'        \
            3 'Parar FIREWALLD'        \
            0 'Voltar ao menu principal'                )

    [ $? -ne 0 ] && clear && exit

    case "$resposta" in
        1)
            dhcp_status=`ps -ax | grep dbsrv16 | sed -n '1p' | cut -d " " -f22`
            if [ $dhcp_status = "/contabil/dados/log/logservidor.txt" ] 
            then
                systemctl stop dhcpd
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-parar
            else
                dialog --title 'Aviso' --msgbox 'Servico offline' 5 40
                menu-parar
            fi
        ;;
        2)
            apache_status=`ps -ax | grep httpd | sed -n '1p' | cut -d " " -f16`
            if [ $apache_status = "/usr/sbin/httpd" ] 
            then
                systemctl stop httpd
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-parar
            else
                dialog --title 'Aviso' --msgbox 'Servico offline' 5 40
                menu-parar
            fi
        ;;
        3)
            firewall_status=`ps -ax | grep firewalld | sed -n '1p' | cut -d " " -f19`
            if [ $firewall_status = "/usr/sbin/firewalld" ] 
            then
                systemctl stop firewalld
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-parar
            else
                dialog --title 'Aviso' --msgbox 'Servico offline' 5 40
                menu-parar
            fi
        ;;
        0)
            menu-principal
        ;;
        *)
            resp-inv
        ;;
    esac
done
}

menu-iniciar(){
while : ; do
  resposta=$(
      dialog --stdout               \
             --title 'ALFRED - INICIAR'  \
             --menu 'Escolha uma opcao' \
            0 0 0                   \
            1 'Iniciar DHCP'        \
            2 'Iniciar APACHE'        \
            3 'Iniciar FIREWALLD'        \
            0 'Voltar ao menu principal'                )

    [ $? -ne 0 ] && clear && exit

    case "$resposta" in
        1)
            dhcp_status=`ps -ax | grep dbsrv16 | sed -n '1p' | cut -d " " -f22`
            if [ $dhcp_status = "/contabil/dados/log/logservidor.txt" ] 
            then
                dialog --title 'Aviso' --msgbox 'Servico online' 5 40
                menu-iniciar
            else
                systemctl start dhcpd
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-iniciar
            fi
        ;;
        2)
            apache_status=`ps -ax | grep httpd | sed -n '1p' | cut -d " " -f16`
            if [ $apache_status = "/usr/sbin/httpd" ] 
            then
                dialog --title 'Aviso' --msgbox 'Servico online' 5 40
                menu-iniciar
            else
                systemctl start httpd
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-iniciar
            fi
        ;;
        3)
            firewall_status=`ps -ax | grep firewalld | sed -n '1p' | cut -d " " -f19`
            if [ $firewall_status = "/usr/sbin/firewalld" ] 
            then
                dialog --title 'Aviso' --msgbox 'Servico online' 5 40
                menu-iniciar
            else
                systemctl start firewalld
                dialog --title 'Aviso' --msgbox 'Operacao realizada com sucesso!' 5 40
                menu-iniciar
            fi
        ;;
        0)
            menu-principal
        ;;
        *)
            resp-inv
        ;;
    esac
done
}

menu-principal(){
while : ; do
# Mostra o menu na tela, com as acoes disponiveis
  resposta=$(
      dialog --stdout               \
             --title 'ALFRED - STATUS'  \
             --menu 'Escolha uma opcao' \
            0 0 0                   \
            1 'Status servico'        \
            2 'Iniciar servico'        \
            3 'Parar servico'        \
            0 'Sair'                )

    # Ela apertou CANCELAR ou ESC, entao vamos sair...
    [ $? -ne 0 ] && clear && exit

    # De acordo com a opcao escolhida, dispara programas
    case "$resposta" in
        1)
            menu-status
        ;;
        2)
            menu-iniciar
        ;;
        3)
            menu-parar
        ;;
        0)
            clear
            exit
        ;;
        *)
            resp-inv
        ;;
    esac
done
}

#EXECUCAO

menu-principal
exit