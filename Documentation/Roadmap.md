# Slasher Manager - Development Roadmap

Ovaj dokument prati razvojni put igre "Slasher Manager" od koncepta do pune verzije.

## Faza 1: Osnovna Mehanika Lova (u toku)
Fokus: Implementacija zabavnog i "juicy" core loop-a.
- [x] **UI Layout:** "Sveska na stolu" (2/3 Mapa, 1/3 Shop).
- [x] **Dinamičke Mete:** Spawn krugova na mapi sa klik interakcijom.
- [x] **HP Sistem:**
    - [x] Mete koje zahtevaju više klikova (Sportista, Vrištavac).
    - [x] Vizuelni feedback oštećenja (tamnjenje/smanjivanje kruga).
- [x] **Sistem Resursa:** Balansiranje dobijanja "Vrisaka" u zavisnosti od težine mete.

## Faza 2: Ekonomija i Prodavnica
Fokus: Davanje svrhe sakupljenim resursima.
- [x] **Kategorizacija Apgrejda:**
    - [x] **Oružje:** Povećava *Click Damage* (za brže ubijanje tankova).
    - [x] **Atmosfera:** Povećava *Gold Gain* (više vrisaka po ubistvu).
    - [x] **Utility:** Povećava *Auto Damage* ("Zarđala žica").
- [x] **Vizuelni Prikaz:** Apgrejdi kao "zalepljeni isečci" u desnom delu sveske (Proceduralni `ShopItemButton`).
- [x] **Auto-Turn:** Implementacija mehanika koje igraju umesto igrača (npr. "Zarđala žica").

## Faza 3: Progresija i Sadržaj
Fokus: Dugoročni ciljevi i raznovrsnost.
- [x] **Boss Borba ("Final Girl"):**
    - [x] Specijalna meta koja se pojavljuje nakon 10 ubistava.
    - [x] Ima 50 HP (mnogo više od običnih žrtava).
    - [x] "Uzvraća udarac" - oduzima 50 vrisaka svakih 3 sekunde.
    - [x] Veća od ostalih žrtava (600x600 umesto 400x400).
    - [x] Vizuelni efekti: crvenkasti ton, upozoravajuće poruke.
    - [x] Nagrada: 500 vrisaka.
- [x] **Novi Nivoi:**
    - [x] Animacija "okretanja stranice". ⚠️ **NOTE: Requires revision - current implementation works but needs polish**
    - [x] Prelazak sa "Kampa na jezeru" na "Predgrađe".
- [x] **Unlockables:** Otključavanje novih tipova žrtava kroz igru.
- [x] **Iskoristiti "victims_unlocked" po levelu:** spawn samo dozvoljenih tipova (ili težinska lista).
- [x] **Primeniti "difficulty_mult":** skaliranje HP/Reward po levelu (uklj. boss).
- [x] **Level-specific boss pool:** `bosses` lista po nivou (spremno za više bossova).
- [x] **Suburbs victim set:** novi tipovi žrtava za suburban mapu (placeholder ikonice).
- [x] **Zamena placeholder ikonica:** ubaciti prave SUBURBS portrete kada budu spremni.
    - [x] `assets/Characters/level_2/neighbor.png`
    - [x] `assets/Characters/level_2/mailman.png`
    - [x] `assets/Characters/level_2/babysitter.png`
    - [x] `assets/Characters/level_2/housewife.png`
    - [x] `assets/Characters/level_2/jogger.png`
    - [x] `assets/Characters/level_2/soccer_dad.png`
    - [x] `assets/Characters/level_2/the_neighborhood_watch_captain_boss.png`
    - [x] `assets/Characters/level_2/the_realestate_mom_boss.png`
    - [x] `assets/Characters/level_2/the_final_girl_boss.png`
- [x] **Level name label:** dodat zaseban label za naziv nivoa iznad mape.

## Faza 4: Poliranje i "Juice"
Fokus: Audio-vizuelni doživljaj (Ink & Paper stil).
- [ ] **Audio Dizajn:**
    - Zvukovi škrabanja olovke, cepanja papira, vrisci.
    - Ambijentalna muzika (šuma, vetar).
- [x] **Tipografija:**
    - [x] Implementacija Patrick_Hand fonta za naslove
    - [x] Implementacija Special_Elite fonta za tekst i brojeve
    - [x] Setovanje fontova u Main.tscn (statički elementi)
    - [x] Setovanje fontova u Main.gd (dinamički elementi)
    - [x] Poboljšanje čitljivosti teksta u upgrade karticama
- [ ] **Vizuelni Efekti (Juice):**
    - [ ] Animacije pri kupovini apgrejda (pulsiranje, "pečatiranje").
    - [ ] Animacija okretanja stranice (doterati detalje):
        - [ ] Podesiti senku ispod “gornje” strane da se bolje vidi dubina.
        - [ ] Suptilan offset “donje” strane (3–6px) za osećaj slojeva.
        - [ ] Fino podešavanje curl širine i highlight‑a u shaderu.
        - [ ] Uskladiti trajanje animacije sa zvukom/page‑turn SFX (kada bude dodat).
    - [x] Podloga ispod page‑turn animacije (donja strana stranice).
    - [x] Screen shake pri eliminaciji žrtve.
    - [x] Ink/blood splatter particles pri eliminaciji.
    - [ ] Bolje animacije krvi (mastila).
    - [ ] Pulse na DPS label (slično kao Screams).
    - [ ] Ink‑splash SFX za eliminaciju (kada bude audio).
- [x] **Restauracija Tekstura:** "Ink & Paper" stil implementiran za Shop.

## Tehnički dug / Stabilnost
- [ ] **Fallback za ime žrtve:** prikaži `NameLabel` kada portret ne može da se učita.
- [ ] **Stabilniji boss ID:** izbeći moguće kolizije `randi()` (npr. brojač ili GUID).
- [ ] **Pouzdaniji boss kill tracking:** proslediti info o boss-u direktno iz instance umesto skeniranja cele `map_area`.

## Faza 5: "The Sequel" (Prestige)
- [ ] Implementacija Soft Reset mehanike (završetak "filma" i snimanje nastavka).
- [ ] Permanentni bonusi za novi playthrough.
