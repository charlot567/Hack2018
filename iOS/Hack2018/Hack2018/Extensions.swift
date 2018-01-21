//
//  Extensions.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit
import UserNotifications

extension UIView {
    
    func centerHorizontalIn(view: UIView) {
        let frame = view.frame
        
        self.frame = CGRect(x: frame.width / 2 - frame.width / 2, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
    }
    
    func centerVerticalIn(view: UIView) {
        let frame = view.frame
        
        self.frame = CGRect(x: frame.width / 2 - self.frame.width / 2, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height)
    }
    
    func center(view: UIView) {
        self.center = view.center
    }
}

extension String {
    
    func lz() -> String {
        let key = self
        
        
        let user = UserDefaults.standard
        var lang = user.value(forKey: "LANGUAGE") as? String
        
        if(lang == nil) {
            lang = "fr"
            
            user.set("fr", forKey: "LANGUAGE")
        }
        
        let dict = [
            "LOGIN_FB": CString(fr: "Connexion avec Facebook", en: "Login with Facebook", es: "Iniciar sesión con Facebook", it: "Accedi con Facebook"),
            "NAO": CString(fr: "Nao", en: "Nao", es: "Nao", it: "Nao"),
            "DISCONNECT_FB": CString(fr: "Déconnexion", en: "Sign Out", es: "Desconectar", it: "Esci"),
            "FETCHING_USER_INFO": CString(fr: "Récupération des infos", en: "Fetching infos", es: "Obteniendo información", it: "Recupero di informazioni"),
            "LANG": CString(fr: "Langage", en: "Language", es: "Idioma", it: "Linguaggio"),
            "SCORE": CString(fr: "Score", en: "Score", es: "Puntuación", it: "Punto"),
            "FUN_FACT": CString(fr: "Fait intéréssant", en: "Fun fact", es: "Hecho de la diversión", it: "Fatto divertente"),
            "MISSION": CString(fr: "Mission", en: "Mission", es: "Misión", it: "Missione"),
            "STATUS": CString(fr: "Progression", en: "Progression", es: "Progresión", it: "Progressione"),
            "COMPLETE": CString(fr: "Status", en: "Status", es: "Estatus", it: "Stato"),
            "TODO": CString(fr: "À faire", en: "To do", es: "Por hacer", it: "Fare"),
            "REWARD": CString(fr: "Récompense", en: "Reward", es: "Recompensa", it: "Ricompensa"),
            "POINT": CString(fr: "points", en: "points", es: "puntos", it: "punti"),
            "START_MISSION" : CString(fr: "Débuter la mission", en: "Start the mission", es: "Comienza la misión", it: "Inizia la missione"),
            "IN_PROGRESS":CString(fr: "En cours", en: "In progress", es: "En curso", it: "In corso"),
            "ARRIVE": CString(fr: "Arrivé à destination", en: "Arrived to destination", es: "Llegada a destino", it: "Arrivato a destinazione"),
            "BRAVO": CString(fr: "Félicitations!", en: "Congratulations!", es: "Felicitaciones", it: "Complimenti"),
            "TABLEVIEW": CString(fr: "Liste de missions", en: "Missions list", es: "Lista de misiones", it: "Lista delle missioni"),
            "PROFILE": CString(fr: "Profile", en: "Profil", es: "Perfil", it: "Profil"),
            "USE_LANG": CString(fr: "En quelle langue voulez-vous utiliser l'application?", en: "In which language would you like to use the app?", es: "¿En qué idioma quieres usar la aplicación?", it: "In quale lingua ti piacerebbe utilizzare l'app?"),
            "FIND_PLANE": CString(fr: "Veuillez trouver une surface plane", en: "Please find a flat surface", es: "Por favor encuentre una superficie plana", it: "Si prega di trovare una superficie piana"),
            "COMPLETED": CString(fr: "Completé", en: "Complete", es: "Terminado", it: "Completare"),
            "SHOW": CString(fr: "Afficher", en: "Show", es: "Visualización", it: "Affiggere"),
            "Continuer": CString(fr: "Continuer", en: "Continue", es: "Seguir", it: "Coninuare"),
            ]

        
        switch lang! {
        case "fr":
            return dict[key]!.fr
        case "en":
            return dict[key]!.en
        case "it":
            return dict[key]!.it
        default:
            return dict[key]!.es
        }
    }
    
}

