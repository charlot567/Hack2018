//
//  Extensions.swift
//  Hack2018
//
//  Created by CharlesOlivier Demers on 18-01-20.
//  Copyright © 2018 Charles-Olivier Demers. All rights reserved.
//

import UIKit

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
        
        let lang = "fr"
        let dict = [
            "LOGIN_FB": CString(fr: "Connexion avec Facebook", en: "Login with Facebook", es: "Iniciar sesión con Facebook"),
            "NAO": CString(fr: "Nao", en: "Nao", es: "Nao"),
            "DISCONNECT_FB": CString(fr: "Déconnexion", en: "Sign Out", es: "Desconectar"),
            "FETCHING_USER_INFO": CString(fr: "Récupération des infos", en: "Fetching infos", es: "Obteniendo información"),
            "LANG": CString(fr: "Language", en: "Language", es: "Idioma"),
            "SCORE": CString(fr: "Score", en: "Score", es: "Puntuación"),
        ]
        
        switch lang {
        case "fr":
            return dict[key]!.fr
        case "en":
            return dict[key]!.en
        default:
            return dict[key]!.es
        }
    }
    
}
