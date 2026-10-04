**1.Rôle de WinRM :** c'est le service Windows qui reçoit les requêtes distantes (protocole WS-Management, au-dessus de HTTP). PowerShell Remoting s'en sert comme « tuyau » pour envoyer des commandes à une autre machine et récupérer les résultats.



**2.Activer PowerShell Remoting :** Enable-PSRemoting -Force. Elle démarre WinRM, crée l'écouteur réseau et ouvre la règle de pare-feu.



**3.Ports :** TCP 5985 (HTTP) et TCP 5986 (HTTPS). Le HTTPS est préférable en production.



**4.Pourquoi le pare-feu bloque :** le port 5985 est fermé tant que la règle WinRM n'est pas activée, et elle est restreinte (ou désactivée) sur les réseaux au profil « Public ». Le pare-feu rejette alors la connexion avant même que WinRM ne la voie.



**5.Test-Connection vs Test-WSMan :** Test-Connection envoie un ping (ICMP) et prouve seulement que la machine est allumée et joignable sur le réseau. Test-WSMan vérifie que le service WinRM répond réellement. Une machine peut répondre au ping et être injoignable en WinRM.



**6.Pourquoi vérifier avant :** pour gagner du temps (éviter d'attendre les timeouts sur chaque machine éteinte), distinguer les causes (machine éteinte, WinRM absent, identifiants refusés) et ne pas bloquer le script sur une machine en échec.



**7.Risques si Remoting est ouvert sans restriction :** n'importe quel compte admin peut exécuter n'importe quoi à distance (mouvement latéral après une compromission), vol ou rejeu d'identifiants (NTLM, HTTP non chiffré, TrustedHosts = \*), peu de traçabilité. Parades : pare-feu limité à l'IP de l'admin, HTTPS, Kerberos, comptes à moindre privilège, JEA, journalisation.

