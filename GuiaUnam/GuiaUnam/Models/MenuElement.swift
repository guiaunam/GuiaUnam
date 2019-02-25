
import UIKit

struct MenuElement{
    let name :          String?
    let description:    String?
    let profileImage:   UIImage?
    let userName:       String?
    static var isSignedIn = false
    //let image: UIImage
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
        self.profileImage = nil
        self.userName = nil
    }
    
    init(profileImage: UIImage?, userName: String) {
        self.userName = userName
        self.name = nil
        self.description = nil
        if let profilePic = profileImage{
            self.profileImage = profilePic
        }else{self.profileImage = UIImage(named: "profile")}
        
    }
    
    
    static func allElementsSignedIn() -> [MenuElement]{
        isSignedIn = true
        return [
            MenuElement(profileImage: nil, userName: "Sesión iniciada"),
            MenuElement(name: "Favoritos", description: "Descubre tus museos favoritos"),
            MenuElement(name: "Por visitar", description: "Organiza tus visitas"),
            MenuElement(name: "Recomendaciones", description: "Basado en tus consultas"),
            MenuElement(name: "Eventos próximos", description: "Nuevos eventos en museos")
            ]
    }
    
    static func allElementsUnsigned() -> [MenuElement]{
        isSignedIn = false
        return [
            MenuElement(profileImage: nil, userName: "Iniciar Sesión"),
            MenuElement(name: "Cerca de ti", description: "Visita un museo cercano")
        ]
    }
    
    //Opciones del menú que aparecerían ya sea si se inició sesión o no.
    static func allElementsMedley() -> [MenuElement]{
        return [
            MenuElement(name: "Noticias", description: "Entérate de lo nuevo")
        ]
    }
}
