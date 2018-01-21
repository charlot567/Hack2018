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
            "LOGIN_FB": CString(fr: "Connexion avec Facebook", en: "Login with Facebook", es: "Iniciar sesión con Facebook"),
            "NAO": CString(fr: "Nao", en: "Nao", es: "Nao"),
            "DISCONNECT_FB": CString(fr: "Déconnexion", en: "Sign Out", es: "Desconectar"),
            "FETCHING_USER_INFO": CString(fr: "Récupération des infos", en: "Fetching infos", es: "Obteniendo información"),
            "LANG": CString(fr: "Langage", en: "Language", es: "Idioma"),
            "SCORE": CString(fr: "Score", en: "Score", es: "Puntuación"),
            "FUN_FACT": CString(fr: "Fait intéréssant", en: "Fun fact", es: "Hecho de la diversión"),
            "MISSION": CString(fr: "Mission", en: "Mission", es: "Misión"),
            "STATUS": CString(fr: "Progression", en: "Progression", es: "Progresión"),
            "COMPLETE": CString(fr: "Status", en: "Status", es: "Estatus"),
            "TODO": CString(fr: "À faire", en: "To do", es: "Por hacer"),
            "REWARD": CString(fr: "Récompense", en: "Reward", es: "Recompensa"),
            "POINT": CString(fr: "points", en: "points", es: "puntos"),
            "START_MISSION" : CString(fr: "Débuter la mission", en: "Start the mission", es: "Comienza la misión"),
            "IN_PROGRESS":CString(fr: "En cours", en: "In progress", es: "En curso"),
            "ARRIVE": CString(fr: "Arrivé à destination", en: "Arrived to destination", es: "Llegada a destino"),
            "BRAVO": CString(fr: "Félicitations!", en: "Congratulations!", es: "Felicitaciones"),
            "TABLEVIEW": CString(fr: "Liste de missions", en: "Missions list", es: "Lista de misiones"),
            "PROFILE": CString(fr: "Profile", en: "Profil", es: "Perfil"),
            "USE_LANG": CString(fr: "En quelle langue voulez-vous utiliser l'application?", en: "In wich language would you like to use the app?", es: "¿En qué idioma quieres usar la aplicación?"),
            "FIND_PLANE": CString(fr: "Veuillez trouver une surface plane", en: "Please find a flat surface", es: "Por favor encuentre una superficie plana"), "Continuer": CString(fr: "Continuer", en: "Continue", es: "Seguir"),
            "COMPLETED": CString(fr: "Completé", en: "Complete", es: "Terminado"),
        ]
        
        switch lang! {
        case "fr":
            return dict[key]!.fr
        case "en":
            return dict[key]!.en
        default:
            return dict[key]!.es
        }
    }
    
}

