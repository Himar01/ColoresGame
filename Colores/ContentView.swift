import SwiftUI
import Foundation

struct ContentView: View {
    let gold = UIColor(red: (209/255.0), green: (172/255.0), blue: (27/255.0), alpha: 1.0)
    let silver = UIColor(red: (172/255.0), green: (210/255.0), blue: (214/255.0), alpha: 1.0)
    let bronze = UIColor(red: (160/255.0), green: (97/255.0), blue: (5/255.0), alpha: 1.0)
    let transparent = UIColor(red: (0/255.0), green: (0/255.0), blue: (0/255.0), alpha: 0)



    @State var inputText: String = "testeando el test"
    @State var score = 0
    @State var rTarget : Double
    @State var gTarget : Double
    @State var bTarget : Double
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    @State var showAlert: Bool
    
    func computeScore() {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        score = Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    func restartColors() {
        rTarget = Double.random(in: 0..<1)
        gTarget = Double.random(in: 0..<1)
        bTarget = Double.random(in: 0..<1)
    }
    func addNewValue(){
        //NO PUEDO HACER CON for winner in ColoresApp.winners porque no me deja asignar valores a los usuarios
        var id = -1
        var winner: User
        for i in 0..<(ColoresApp.winners.count) {
            winner = ColoresApp.winners[i]
            if(winner.name == inputText){
                id = i
            }
        }
        
            if(id != -1){
                if(ColoresApp.winners[id].bestValue<score){
                    ColoresApp.winners[id].bestValue = score
                    restartScore()
                }
            }else{
                if(inputText == ""){
                    inputText = "Anonymous"
                }
                ColoresApp.winners.append(User(id: ColoresApp.winners.count+1, name: inputText, bestValue: score,avatar: Image(systemName: "flag.2.crossed.fill"),color: .white, date: self.getDate()))
                restartScore()
            }
        
    }
    func restartScore(){
        ColoresApp.winners = ColoresApp.winners.sorted(by: { $0.bestValue > $1.bestValue })
        
        //TODO: Improve this statement
        switch ColoresApp.winners.count{
        case 0:
            break
        case 1:
            ColoresApp.winners[0].color = Color(self.gold)
        case 2:
            ColoresApp.winners[0].color = Color(self.gold)
            ColoresApp.winners[1].color = Color(self.silver)
        case 3:
            ColoresApp.winners[0].color = Color(self.gold)
            ColoresApp.winners[1].color = Color(self.silver)
            ColoresApp.winners[2].color = Color(self.bronze)
        default:
            ColoresApp.winners[0].color = Color(self.gold)
            ColoresApp.winners[1].color = Color(self.silver)
            ColoresApp.winners[2].color = Color(self.bronze)
            ColoresApp.winners[3].color = Color(self.transparent)
        }
    }
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    NavigationLink(destination:
                                    TopListView()){
                        Label("Top List", systemImage: "person.3")
                    }.foregroundColor(.blue)
                        .padding([.top,.trailing],10)
                        .padding(.bottom, 2)
                        .font(.system(size:16))
                }
                HStack{
                    VStack{
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        Text("Match this color!")
                    }
                    VStack{
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("R: \(Int(rGuess * 255.0))"
                             + "G: \(Int(gGuess * 255.0))"
                             + "B: \(Int(bGuess * 255.0))")
                    }
                }
                Button(action: {
                    showAlert=true
                    computeScore()
                    addNewValue()
                    restartColors()
                }){
                    Text("Comprobar")
                }.alert(isPresented:$showAlert){
                    Alert(title: Text("Your Score"),
                          message: Text(String(score)))
                }.padding()
                ColorSlider(value:$rGuess, textColor: .red)
                ColorSlider(value:$gGuess, textColor: .green)
                ColorSlider(value:$bGuess, textColor: .blue).padding(.bottom,10)
                HStack(){
                    Text("Nombre: ")
                        .padding(.leading,10)
                    TextField("Escribe tu nombre", text: $inputText)
                }
                .padding(.bottom, 20.0)}.onAppear {
                restartColors()
            }.navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
    }
}

struct ColorSlider: View {
    @Binding var value:Double
    var textColor: Color
    var body: some View{
        HStack{
            Text("0")
                .foregroundColor(textColor)
            Slider(value: $value)
                .tint(textColor)
            Text("255")
                .foregroundColor(textColor)
        }.padding(.horizontal)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rTarget: 0, gTarget: 0, bTarget: 0,rGuess: 0.5, gGuess: 0.5, bGuess: 0.5,  showAlert: false)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
                .previewDisplayName("iPhone 14")
    }
}


