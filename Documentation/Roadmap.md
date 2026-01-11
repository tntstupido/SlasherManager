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
- [ ] **Novi Nivoi:**
    - Animacija "okretanja stranice".
    - Prelazak sa "Kampa na jezeru" na "Predgrađe".
- [ ] **Unlockables:** Otključavanje novih tipova žrtava kroz igru.

## Faza 4: Poliranje i "Juice"
Fokus: Audio-vizuelni doživljaj (Ink & Paper stil).
- [ ] **Audio Dizajn:**
    - Zvukovi škrabanja olovke, cepanja papira, vrisci.
    - Ambijentalna muzika (šuma, vetar).
- [ ] **Vizuelni Efekti (Juice):**
    - [ ] Animacije pri kupovini apgrejda (pulsiranje, "pečatiranje").
    - [ ] Animacija okretanja stranice.
    - [ ] Screen shake i particles pri eliminaciji žrtve.
    - [ ] Bolje animacije krvi (mastila).
- [x] **Restauracija Tekstura:** "Ink & Paper" stil implementiran za Shop.

## Faza 5: "The Sequel" (Prestige)
- [ ] Implementacija Soft Reset mehanike (završetak "filma" i snimanje nastavka).
- [ ] Permanentni bonusi za novi playthrough.
