Ovo je detaljan pregled **gameplay loop-a (petlje igranja)** za tvoj koncept "Slasher Menadžer", fokusiran na interakciju sa tim krugovima (metama) i napredak kroz svesku.

Gameplay je dizajniran da bude **zadovoljavajući (juicy)**, jednostavan za početak, ali sa dovoljno dubine da zadrži igrača.

### ---

**1\. Osnovna Mehanika: "Lov" (Active Play)**

Ovo se dešava na levoj strani sveske (na mapi).

* **Interakcija sa krugovima (Metama):**  
  * Svaki karakter (krug) ima **"Health Bar"** (liniju života), ali u tvom stilu to nije klasičan bar, već **krug nacrtan olovkom oko njihove glave**.  
  * **Kliktanje:** Svaki put kad klikneš na metu (npr. "Gik"), linija kruga se briše ili postaje crvenija.  
  * **Eliminacija:** Kada "HP" padne na nulu:  
    1. Čuje se zvuk oštrog škrabanja i kratak vrisak.  
    2. Preko lica se pojavljuje onaj **veliki crveni X** (ili mrlja).  
    3. Izbacuje se resurs (npr. "+150 Vrisaka").  
    4. Portret postaje siv (neaktivan) na par sekundi.  
* **Respawn (Ponovno pojavljivanje):**  
  * Nakon 3-5 sekundi (ili brže sa apgrejdima), gumica "obriše" crveni X, i pojavljuje se nova žrtva na istom mestu (npr. Gika zameni "Dostavljač pice").  
* **Tipovi Žrtava (Različita otpornost):**  
  * **Turista:** Umire od 1 klika. (Laka zarada).  
  * **Sportista:** Treba mu 10 klikova (Beži brže).  
  * **Vrištavac (Screamer):** Daje dupli resurs ako ga eliminišeš brzo.

### ---

**2\. Automatizacija: "Zamke i Pomoćnici" (Idle Play)**

Kako igrač ne bi morao stalno da klikće, kupuje stvari koje "oštećuju" žrtve automatski.

* **Vizuelni prikaz na mapi:**  
  * Kada kupiš automatski apgrejd, on se nacrta na mapi kao mala skica pored putića.  
* **Primeri automatizacije:**  
  * **Zarđala žica:** Skida 1 HP svake sekunde svim žrtvama. (Crtež žice na mapi).  
  * **Jezivi telefonski poziv:** Povremeno "stunuje" žrtvu (ne može da regeneriše health).  
  * **Pomoćnik (Mlađi brat):** Automatski precrtava najslabije mete umesto tebe.

### ---

**3\. Sistem Napredovanja: "Okretanje Stranice" (Level Up)**

Ovo je ključno da igra ne dosadi. Mapa ne ostaje ista zauvek.

* **Boss Borba ("Final Girl"):**  
  * Nakon što eliminišeš npr. 50 žrtava na prvoj mapi ("Kamp na jezeru"), pojavljuje se **"Final Girl"** (glavna junakinja filma).  
  * Ona je u većem krugu, ima mnogo više HP-a i uzvraća udarac (može da ti privremeno onemogući kursor/nož).  
* **Nova Lokacija:**  
  * Kada pobediš Boss-a, ruka animirano **okreće stranicu sveske**.  
  * Otvara se nova mapa: **"Predgrađe" (Suburbia)**.  
  * Nove mete: Komšinica, Poštar, Bebisiterka.  
  * Novi apgrejdi specifični za tu mapu (npr. "Kosilica za travu").

### ---

**4\. Ekonomija i Prodavnica (Desna strana sveske)**

Ovde trošiš "Vriske". Podeljeno u tri kategorije sarkastičnih apgrejda:

1. **Oružje (Klik Moć):**  
   * Povećava štetu po kliku.  
   * *Primer:* "Kuhinjski nož" \-\> "Mačeta" \-\> "Motorna testera" \-\> "Rukavica sa sečivima".  
2. **Atmosfera (Pasivni prihod):**  
   * Povećava koliko vrisaka dobijaš po žrtvi.  
   * *Primer:* "Magla mašina" (Svi se više plaše). "Jeziva muzika u pozadini".  
3. **Utility (Korisne sitnice):**  
   * *Primer:* "Kofein" (Brži respawn žrtava). "Podmićeni policajac" (Smanjuje težinu Bossa).

### ---

**5\. Prestige Sistem: "The Sequel" (Nastavak)**

Kada igra postane preteška ili spora (obično nakon 3\. ili 4\. mape/nivoa), igrač radi **Soft Reset**.

* **Dugme:** "Snimi Nastavak (Sequel)".  
* **Šta se dešava:**  
  * Vraćaš se na početak (Kamp na jezeru).  
  * Gubiš sve apgrejde i novac.  
  * **DOBIJAŠ:** "Kultni Status" (Nova valuta).  
* **Efekat:** Svaki poen Kultnog Statusa ti daje \+10% na svu zaradu zauvek. Takođe, otključava "Directors Cut" apgrejde (npr. žrtve eksplodiraju kad umru).

### ---

**Kako ovo izgleda u kodu (Godot logika)?**

1. **Scene:** Glavna scena je BookNode.  
2. **Targets:** Svaki krug je instanca EnemyScene.  
   * Ima varijablu current\_hp i max\_hp.  
   * Signal on\_click: current\_hp \-= player\_click\_damage.  
   * Ako current\_hp \<= 0: play animation "Death", emit signal "money\_earned", start timer "Respawn".  
3. **Global Script (Singleton):** Prati total\_screams, click\_damage, auto\_damage\_per\_second.

Da li ti ovaj tok igre (Game Loop) zvuči zabavno za pravljenje? Deluje li izvodljivo?