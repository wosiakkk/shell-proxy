#!/bin/bash

#CONFIGURAÇÃO DO SCRIPT, endereços das acls que serão editadas e outros arquivos necessarios
######################################################################################################################################
access='/home/predati/Documentos/access.log'                             #diretorio do access.log
access_temp='/home/predati/Documentos/temp.log'                          #arquivo temporario usado em pesquisas no log
atualiza='/home/predati/Documentos/admproxy/acl/atualiza.txt'            #arquivo de uso temporario pra a regravacao de acls
acl_bloq='/home/predati/Documentos/admproxy/acl/sites_bloqueados.txt'    #diretorio da acl de sites bloqueados
acl_gov='/home/predati/Documentos/admproxy/acl/sites_gov.txt'            #diretorio da acl de sites padroes .gov
acl_horario='/home/predati/Documentos/admproxy/acl/horario.txt'          #diretorio da acl de sites limitados por horarios
acl_mail='/home/predati/Documentos/admproxy/acl/mail.txt'                #diretorio da acl de emails
acl_livre='/home/predati/Documentos/admproxy/acl/livre.txt'              #diretorio da acl de internet livre
squid_conf='/etc/squid/squid.conf'                                       #diretorio do squid.conf
squid_error='/home/predati/Documentos/admproxy/error.log'                #arquivo de dados temporarios para verificar erros de comandos do squid
######################################################################################################################################
 #BUG RESOLVIDO

menu_url(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
        clear
	echo "------------------------------"
	echo "| Menu URL                   |"
	echo "------------------------------"
	echo
	echo
        echo "1- Bloquear uma URL."
      	echo "2- Listar URLs."
	echo "3- Procurar uma URL."
	echo "4- Desbloquear uma URL."
	echo "5- Voltar."
	echo
	read opcao
	case $opcao in
	     1)
	  	echo "Informe a URL:"
		read url
		cat $acl_bloq | grep $url > /dev/null #verific se a url existe 1º,e jogando o resultado no null para n aparecer na tela
		if [ $? -eq 0 ]; then #verificando o retorno do cat,caso haja retorno, da verdade, pelo contrario falso no if.
		   echo
    		   echo "Esta URL ja existe na acl."
		   else
		       echo "URL add com sucesso."
   		       echo $url >> $acl_bloq	
		fi		
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_url ;;
	     2)
		echo
		echo "Resultado:"
		echo
		more $acl_bloq
	        echo
	        echo "Pressione qualquer tecla para sair."
	        read Enter
	        menu_url
		 ;;
	     3)
		echo "Digite a URL que deseja pesquisar:"
		read pesq
		echo
		echo "Resultado:"
		echo
		cat $acl_bloq | grep $pesq
		if [ $? -eq 0 ]; then 
		   echo
    		   echo "URL(s) encontrada(s)."
		   else
		       echo "Nenhuma URL encontrada."   		       
		fi	
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_url ;;
	     4)
		echo "Digite a URL que deseja excluir da acl:"
		read apagar
		cat $acl_bloq | grep $apagar > /dev/null 
		if [ $? -eq 0 ]; then 
		   cat $acl_bloq | grep -v $apagar > $atualiza
		   cp $atualiza  $acl_bloq
		   echo "URL apagada da acl."
		   echo	
		   else
		       echo "URL não existe na acl."
		fi	
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_url ;;
	     5)
		verificador=$"0"
		menu_2;;
	esac
     done	
}

menu_gov(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
        clear
	echo "------------------------------"
	echo "| Menu Sites padroes & .Gov  |"
	echo "------------------------------"
	echo
	echo
        echo "1- Adicionar uma URL."
      	echo "2- Listar URLs."
	echo "3- Procurar uma URL."
	echo "4- Apagar  uma URL."
	echo "5- Voltar."
	echo
	read opcao
	case $opcao in
	    1)
	  	echo "Informe a URL:"
		read url
		cat $acl_gov | grep $url > /dev/null  
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "Esta URL ja existe na acl."
		   else
		       echo "URL add com sucesso."
   		       echo $url >> $acl_gov	
		fi		
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_gov ;;
	     2)
		echo
		echo
		echo "Resultado:"
		echo
		more $acl_gov
		echo
	        echo
	        echo "Pressione qualquer tecla para sair."
	        read Enter
	        menu_gov
		 ;;
	     3)
		echo "Digite a URL que deseja pesquisar:"
		read pesq
		echo
		echo
		echo "Resultado:"
		echo
		cat $acl_gov | grep $pesq
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "URL(s) encontrada(s)."
		   else
		       echo "Nenhuma URL encontrada."  		       
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_gov ;;
	     4)
		echo "Digite a URL que deseja excluir da acl:"
		read apagar
		cat $acl_gov | grep $apagar > /dev/null #verificando se a url existe antes de apagar
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $acl_gov | grep -v $apagar > $atualiza
		   cp $atualiza  $acl_gov
		   echo "URL apagada da acl."
		   echo	
		   else
		       echo "URL não existe na acl."
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_gov ;;
	     5)
		verificador=$"0"
		menu_2;;
	esac
     done	
}

menu_horario(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
        clear
	echo "------------------------------"
	echo "| Menu Horario               |"
	echo "------------------------------"
	echo
	echo
        echo "1- Adicionar uma URL."
      	echo "2- Listar URLs."
	echo "3- Procurar uma URL."
	echo "4- Apagar  uma URL."
	echo "5- Voltar."
	echo
	read opcao
	case $opcao in
	    1)
	  	echo "Informe a URL:"
		read url
		cat $acl_horario | grep $url > /dev/null  
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "Esta URL ja existe na acl."
		   else
		       echo "URL add com sucesso."
   		       echo $url >> $acl_horario	
		fi		
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_horario ;;
	     2)
		echo
		echo
		echo "Resultado:"
		echo
		more $acl_horario
	        echo
		echo
	        echo "Pressione qualquer tecla para sair."
	        read Enter
	        menu_horario
		 ;;
	     3)
		echo "Digite a URL que deseja pesquisar:"
		read pesq
		echo
		echo
		echo "Resultado:"
		echo
		cat $acl_horario | grep $pesq
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "URL(s) encontrada(s)."
		   else
		       echo "Nenhuma URL encontrada."   		       
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_horario ;;
	     4)
		echo "Digite a URL que deseja excluir da acl:"
		read apagar
		cat $acl_horario | grep $apagar > /dev/null #verificando se a url existe antes de apagar
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $acl_horario | grep -v $apagar > $atualiza
		   cp $atualiza  $acl_horario
		   echo "URL apagada da acl."
		   echo	
		   else
		       echo "URL não existe nesta acl."
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_horario ;;
	     5)
		verificador=$"0"
		menu_2;;
	esac
     done	
}

menu_mail(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
        clear
	echo "------------------------------"
	echo "| Menu Mail                  |"
	echo "------------------------------"
	echo
	echo
        echo "1- Adicionar uma URL."
      	echo "2- Listar URLs."
	echo "3- Procurar uma URL."
	echo "4- Apagar  uma URL."
	echo "5- Voltar."
	echo
	read opcao
	case $opcao in
	    1)
	  	echo "Informe a URL:"
		read url
		cat $acl_mail | grep $url > /dev/null  
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "Esta URL ja existe na acl."
		   else
		       echo "URL add com sucesso."
   		       echo $url >> $acl_mail	
		fi		
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_mail ;;
	     2)
		echo
		echo
		echo "Resultado:"
		echo
		more $acl_mail
	        echo
		echo
	        echo "Pressione qualquer tecla para sair."
	        read Enter
	        menu_mail
		 ;;
	     3)
		echo "Digite a URL que deseja pesquisar:"
		read pesq
		echo
		echo
		echo "Resultado:"
		echo
		cat $acl_mail | grep $pesq
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "URL(s) encontrada(s)."
		   else
		       echo "Nenhuma URL encontrada."   		       
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_mail ;;
	     4)
		echo "Digite a URL que deseja excluir da acl:"
		read apagar
		cat $acl_mail | grep $apagar > /dev/null #verificando se a url existe antes de apagar
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $acl_mail | grep -v $apagar > $atualiza
		   cp $atualiza  $acl_mail
		   echo "URL apagada da acl."
		   echo	
		   else
		       echo "URL não existe nesta acl."
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_mail ;;
	     5)
		verificador=$"0"
		menu_2;;
	esac
     done	
}

menu_livre(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
        clear
	echo "------------------------------"
	echo "| Menu Internet Livre        |"
	echo "------------------------------"
	echo
	echo
        echo "1- Adicionar uma URL."
      	echo "2- Listar URLs."
	echo "3- Procurar uma URL."
	echo "4- Apagar  uma URL."
	echo "5- Voltar."
	echo
	read opcao
	case $opcao in
	    1)
	  	echo "Informe a URL:"
		read url
		cat $acl_livre | grep $url > /dev/null  
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "Esta URL ja existe na acl."
		   else
		       echo "URL add com sucesso."
   		       echo $url >> $acl_livre	
		fi		
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_livre ;;
	     2)
		echo
		echo
		echo "Resultado:"
		echo
		more $acl_livre
	        echo
		echo
	        echo "Pressione qualquer tecla para sair."
	        read Enter
	        menu_livre
		 ;;
	     3)
		echo "Digite a URL que deseja pesquisar:"
		read pesq
		echo
		echo
		echo "Resultado:"
		echo
		cat $acl_livre | grep $pesq
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   echo
    		   echo "URL(s) encontrada(s)."
		   else
		       echo "Nenhuma URL encontrada."  		       
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_livre ;;
	     4)
		echo "Digite a URL que deseja excluir da acl:"
		read apagar
		cat $acl_livre | grep $apagar > /dev/null #verificando se a url existe antes de apagar
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $acl_livre | grep -v $apagar > $atualiza
		   cp $atualiza  $acl_livre
		   echo "URL apagada da acl."
		   echo	
		   else
		       echo "URL não existe nesta acl."
		fi	
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		menu_livre ;;
	     5)
		verificador=$"0"
		menu_2;;
	esac
     done	
}

menu_2(){
    verificador=$"1"
    while [ $verificador -eq 1 ];
      do	
	clear
	echo "------------------------------"
	echo "| Proxy PRED                 |"
	echo "------------------------------"
	echo
        echo
        echo "1- Sites Bloqueados."
        echo "2- Sites Padroes e Governamentais."
	echo "3- Sites Com Horario Restrito."
        echo "4- Dominio de e-mails."
	echo "5- Internet Livre."
	echo "6- Voltar."
	echo
	read opcao
	case $opcao in
	     1)
		menu_url ;;
	     2)
		menu_gov
		;;
	     3)
		menu_horario
		;;
	     4)
		menu_mail
		;;
	     5)
		menu_livre
		;;
	     6)
		verificador=$"0";;
    	esac
      done
 main		  	
}

menu_log(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
	clear
	echo "------------------------------"
	echo "| Access Log                 |"
	echo "------------------------------"
	echo
        echo "1- Pesquisa usr+url."
        echo "2- Pesquisa usr."
        echo "3- Pesquisa ip."
	echo "4- Pesquisa url"
        echo "5- Voltar ."
	echo 
	echo
	read opcao
	case $opcao in
	     1)
 		echo
		echo "Informe o usuario:"
		read usr
		echo "Informe a url"
		read url 
		cat $access | grep --color -w "$usr" > /dev/null
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $access | grep --color -w "$usr" > $access_temp
		   echo
    		   echo "Usuario encontrado!"
		   sleep 1
		   cat $access_temp | grep --color -w "$url" > /dev/null
		   if [ $? -eq 0 ]; then #verificando o retorno do cat
		        echo
    		   	echo "Url encontrada!"
		   	sleep 1
			grep --color "$usr\|$url" $access_temp 
		   	else
		       	     echo "Nenhuma url encontrada."
		    fi
		   else
			echo "Usuario nao encontrado!"	
		fi
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		;;
	     2)
		echo
		echo "Informe o usuario:"
		read usr
		cat $access | grep --color -w "$usr" > /dev/null
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $access | grep --color -w "$usr" > $access_temp
		   echo
    		   echo "Usuario encontrado!"
		   sleep 1
		   grep --color "$usr" $access_temp
		   else
			echo "Usuario nao encontrado!"
		fi
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		;;
	     3)
		echo
		echo "Informe o IP:"
		read ip
		cat $access | grep --color -w "$ip" > /dev/null
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $access | grep --color -w "$ip" > $access_temp
		   echo
    		   echo "IP encontrado!"
		   sleep 1
		   grep --color "$ip" $access_temp
		   else
			echo "IP nao encontrado!"
		fi
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		;;
	     4)
		echo
		echo "Informe a url:"
		read url
		cat $access | grep --color -w "$url" > /dev/null
		if [ $? -eq 0 ]; then #verificando o retorno do cat
		   cat $access | grep --color -w "$url" > $access_temp
		   echo
    		   echo "URL encontrada!"
		   sleep 1
		   grep --color "$url" $access_temp
		   else
			echo "URL nao encontrada!"
		fi
		echo
		echo
		echo "Pressione qualquer tecla para sair."
		read Enter
		;;
	     
	     5)
		verificador=$="0"
		;;
	esac
done
main	
}

menu_edit(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
	clear
	echo "------------------------------"
	echo "| Edit Squid.conf            |"
	echo "------------------------------"
	echo
        echo "1- Pico."
        echo "2- Vi."
        echo "3- Gedit."
	echo "4- Sair"
	echo
        read opcao
        case $opcao in
	     1)
		pico $squid_conf ;;
	     2)
		vi $squid_conf ;;
	     3)
		gedit $squid_conf ;;
	     4)
		verificador=$"0"
	esac
   done
main
}

main(){
   verificador=$"1"
   while [ $verificador -eq 1 ];
     do
	clear
	echo "------------------------------"
	echo "| Proxy PRED                 |"
	echo "------------------------------"
	echo
        echo "1- Pesquisa Log."
        echo "2- URL."
        echo "3- Reload Squid."
	echo "4- Editar squid.conf"
        echo "5- Sair."
	echo
        read opcao
        case $opcao in
	     1)
		menu_log
		;;
	     2)		
		menu_2 
	        ;;
	     3)
		squid -k reconfigure
		squid reload 
		if [ $? -eq 0 ]; then #condicao q verifica se n houve erros na exe dos comandos do squid
		   echo
    		   echo "Squid reconfigurado com sucesso, pressione qualquer tecla para voltar."
		   else
		       echo
   		       echo "Houve problemas ao reconfigurar o squid, verifique o squid.conf!"
		       echo "Pressione qualquer tecla para voltar."	
		fi
		read Enter
		;;
	     4)
		 menu_edit
		 ;;
	     5)
		verificador=$"0"
		exit
		;;
         esac
     done
}
main

