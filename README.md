# Realdolmen Stage Flutter - Honore Pacifique - Bayisenge

## Schooler

App, ontwikkeld met Flutter, die de school inschrijvingen voor ouders en/of studenten vereenvoudigd.

## Logboek

---

#### 29/09 Woensdag ####

* Flutter setup
  * Flutter basis app aanmaken

* Main Activity
  * De main activity is het inschrijven in scholen. Hier ligt de focus dus op vervolgens voegt men de andere eigenschappen toe.

* App ontruimen
  * De dummy code verwijderen en basisknoppen naar een nieuw venster toevoegen

#### 30/09 Donderdag ####

* Bottom navigation bar
  * Knoppen verwijzen nog naar niks => template

#### 04/10 Donderdag ####

* Bottom navigation bar
  * Rounded, floating, box shadow

---
---
---

#### 05/10 Maandag ####

* new page popup
  * Popup pagina voor nieuwe inschrijvingen

* Stepper
  * Stappen per vragen onderdeel implementeren
  * Geraamte
  * Issue => layout render overflow

#### 06/10 Woensdag ####

* new page popup
  * Popup pagina voor nieuwe inschrijvingen

* Stepper  
  * Geraamte opvullen
  * Issue => layout render overflow => fixed met de expanded widget

#### 07/10 Donderdag ####

* Stepper  
  * Geraamte opvullen
  * Issue => bullet point animatie lanceert ook als de pagina niet wordt weergegeven

#### 08/10 Vrijdag ####

* Page slider  
  * Stepper vervangen door page slider widget
  * Geraamte
  * geraamte opvullen
  * Issue => bullet point animatie lanceert niet
  * TO DO:  2 laatste pagina's opvulllen => school voorkeur + data overzicht

* Progress Stepper
  * Stappen indicator
  * TO DO: kleur ???

---
---
---

#### 11/10 Maandag ####

* Custom Widget
  * Code leesbaar maken door te splitsen in verschillende widgets

* Form
  * Validatie van de velden
  * Data efficient kunnen ophalen => voorlopig heel veel if's
  * Vragen beter organiseren => dynamisch maken voor de volgende use case's

* Homescreen
  * Lege pagina opvullen met een call to action

#### 13/10 Woensdag ####

* Form
  * Validatie van de velden
  * Data efficient kunnen ophalen => voorlopig heel veel if's
  * Helemaal herschrijven met nieuw flutter package

* Form validators
  * Custom validators om eige logica te creeren -> rijksregisternummer controle
  * Issue => volgende forms global key current state altijd NULL

#### 14/10 Donderdag ####

* Klassen
  * Registratie klasse om de data op te slaan en/of naar server te versturen
  * Issue -> heel slordige constructor -> heel veel arguments
  * User klasse om de inlog data van de user bij te houden -> bestaande data hergebruiken bij (her)inschrijvingen

* Form
  * Validatie van de velden => afgewerkt
  * Data efficient kunnen ophalen => voorlopig heel slordige opvraag contructor van de classe
  
* Form validators
  * Issue => volgende forms global key current state altijd NULL => afgewerkt

* Dummy data
  * Dummy data file om inkomende data te simuleren

* Notification page
  * Inschrijving UI design ontwikkeling -> nog niet af
  * Card widget gebruiken ?

* Registratie
  * Vragen zijn afgewerkt samen met hun validatie
  * TO DO => scholen rangschikking !!!

#### 15/10 Vrijdag ####

* Klassen
  * Issue -> heel slordige constructor -> heel veel arguments -> oplossing: verschillende onderdeel klassen ??
  * User klasse om de inlog data van de user bij te houden -> bestaande data hergebruiken bij (her)inschrijvingen

* Form
  * Data efficient kunnen ophalen => voorlopig heel slordige opvraag contructor van de klasse

* Dummy data
  * Dummy data file om inkomende data te simuleren

* Notification page
  * Inschrijving UI design ontwikkeling -> nog niet af
  * Card widget gebruiken -> in ontwikkeling -> TO DO: bij klik vergroot animatie met meer info
  * Animatie bij weergeven van de kaarten

* Registratie
  * TO DO => scholen rangschikking !!!

* New Popup
  * Gebruiker kan de popup niet sluiten met de back button van de device

---
---
---

#### 18/10 Maandag ####

* Klassen
  * Issue -> heel slordige constructor -> heel veel arguments -> oplossing: verschillende onderdeel klassen ??
  * User klasse om de inlog data van de user bij te houden -> bestaande data hergebruiken bij (her)inschrijvingen

* Form
  * Data efficient kunnen ophalen => voorlopig heel slordige opvraag contructor van de klasse

* Dummy data
  * Dummy data file om inkomende data te simuleren
  * Scholen data simuleren ??

* Notification page
  * Inschrijving UI design ontwikkeling -> nog niet af
  * Card widget gebruiken -> in ontwikkeling ->  bij klik vergroot animatie met meer info -> geusture detector widget om klik na te bootsen  ??
  * Animatie bij weergeven van de kaarten -> Done !

* Registratie
  * TO DO => scholen rangschikking !!!

* New Popup
  * Gebruiker kan de popup niet sluiten met de back button van de device

* Code Clean up
  * Herbruikbare variabels
  * Comments !!!
  * Onnodige code verwijderen en "test" code juist benoemen

#### 20/10 Woensdag ####

* Klassen
  * Issue -> heel slordige constructor -> heel veel arguments -> oplossing: verschillende onderdeel klassen ??
  * User klasse om de inlog data van de user bij te houden -> bestaande data hergebruiken bij (her)inschrijvingen

* Form
  * Data efficient kunnen ophalen => voorlopig heel slordige opvraag contructor van de klasse

* Dummy data
  * Scholen data simuleren -> scholen lijst -> strings...

* Notification page
  * Inschrijving UI design ontwikkeling -> nog niet af
  * Card widget gebruiken -> in ontwikkeling ->  bij klik vergroot animatie met meer info -> Inkwell = mooier en material ripple effect
  * Nieuwe pagina bij het klikken van de card
  * Scholen voorkeur in Card UI => Chips
  * Geslacht icon ?? -> Circle Avatar

* Registratie
  * TO DO => scholen rangschikking !!!

#### 20/10 Donderdag ####

* Klassen
  * Issue -> heel slordige constructor -> heel veel arguments -> oplossing: verschillende onderdeel klassen ??
  * User klasse om de inlog data van de user bij te houden -> bestaande data hergebruiken bij (her)inschrijvingen
  * Klassen methoden -> OOP

* Form
  * Data efficient kunnen ophalen => voorlopig heel slordige opvraag contructor van de klasse

* Dummy data
  * Scholen data simuleren -> scholen lijst -> strings...

* Notification page
  * Inschrijving UI design ontwikkeling -> 80% voltooid
  * Card widget gebruiken -> in ontwikkeling ->  bij klik vergroot animatie met meer info -> Inkwell => niet mooi dus gewoon popup
  * Nieuwe pagina bij het klikken van de card => afgewerkt
  * Scholen voorkeur in Card UI => Chips => rangschikking
  * Geslacht icon ?? -> Circle Avatar => dropped

* Registratie
  * TO DO => scholen rangschikking !!!

* Code clean up
  * Onnodige code verwijderen
  * Methoden en klassen vereenvoudigen
  * Shortcuts
