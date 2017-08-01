# Bilan de la ludum dare 39

 <p>
  La ludum dara 39 a commencé le 29/07/2017 à 3:00, j'ai participé à la jam qui dure 72h.
  Mon jeu est un plate-former créer avec la console fantaisiste TIC-80
  dont le but est de recolter les piles avant que tes points de vie ne tombe à zéro.
  tes points de vie se réduise avec le temps, si tu fais une action comme attaquer,sauter
  ou bouger, tes points de vie se réduise aussi.
</p>
 <h2>lien</h2>
  <p><strong>itch.io : </strong>https://kanatos.itch.io/warrior-machine</p>
  <p><strong>mega : </strong>https://mega.nz/fm/hKR3lRBD</p>
  <p><strong>ludum-dare : </strong>https://ldjam.com/events/ludum-dare/39/warrior-machine-1</p>
 <h2>commandes</h2>
 <ul>
  <li>Touche directionnel = bouger le personnage</li>
  <li>W                   = sauter</li>
  <li>X                   = tirer</li>
   <li><strong>/!\Les touches sont celles du clavier qwerty/!\</strong></li>
</ul>
 <h2>Outils utilisé</h2>
 <ul>
  <li>TIC-80</li>
  <li>GraphicsGale</li>
  <li>Gimp2</li>
  <li>Sublime-text 3</li>
</ul> 
 <h2>Point positif</h2>
 <ul>
  <li>
    <h3>L'utilisation de la console fantaisiste TIC-80</h3>
    <p>J'ai appris pleines de nouvelle chose sur celle console, comme la puissance des function
    poke, la quantité de donnée que peut stocker la console(si j'aurais participé avec la PICO-8, je n'aurais
    surement pas pus tout mettre). J'ai aussi pu touché à l'éditeur de sons qui est simple d'utilisation lorsque
    l'on connait bien l'éditeur.(je conseille de jeter un oeil sur les jeux musicaux que propose la TIC-80)</p>
  </li>  
  <li>
    <h3>L'utilisation de Sublime-text3</h3>
    <p>Avant de commencer la jam, j'avais déjà installer le package TIC-80 qui me permettait de coder et 
       de tester le jeux. Ca m'a beaucoup aidé lors du developpemnt du jeux, je pouvais avoir un aperçu
       des traces.</p>
  </li>  <li>
    <h3>language lua</h3>
    <p>Le lua est le premier language que j'ai appris. J'ai conçus un système pendant le devellopement du jeux
       qui me permettait de débuguer mon jeux et d'éviter les boucles infinis. J'ai aussi pus mettre en place
       les snippets que j'avais installé préalablement, les snippets m'ont fait gagner un temps considérable
       donc je suis pas mécontent d'avoir passer du temps à les installer.
       Le snippet dont je suis le plus fière est celui de la gestion du gamestate, bien qu'incomplet, j'ai pus
      le modifier rapidement et de le rendre fonctionnel.
    </p>
  </li>
</ul>
 <h2>Point negatif</h2>
 <ul>
  <li>
    <h3>bug de collision-solid</h3>
    <p>J'ai perdu beaucoup de temps sur cette fonctionnalité, je savais que j'allais me prendre la tête sur celle
    là... J'avais créer un snippet exprès pour gérer ce cas, mais je l'avais pris sur PICO-8 et des fonction de PICO-8
    ne sont pas sur la TIC-80, de plus ma fonction while ne fonctionnait pas et elle été imbuvable...</p>
  </li>  
  <li>
    <h3>bug de camera</h3>
    <p>Celle là été une plaie à coder sur TIC-80! La camera suivait mal mon personnage où les collisions été cassée.
    J'ai du opter à une solution qui à sacrément complexifier le code...</p>
  </li>
  <li>
    <h3>bug de collisionBox</h3>
    <p>paragraphe...</p>
  </li>
  <li>
    <h3>visibilité du code sur sublime-text 3</h3>
    <p>J'essais toujour d'aérer du mieux que je puisse mon code mais au bout de 500-600 lignes,
    lorsque l'ont doit aller de la ligne 0 à la ligne 474 pour checker une information c'est
    une douleur au cerveau, il faudrait que je voit si il y a pas un moyen d'avoir des marques-pages
    commen avec zérobrane studio.</p>
  </li>
</ul>
<p>
 <h2>idée d'amelioration</h2>
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
</p>
