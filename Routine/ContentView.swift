//
//  ContentView.swift
//  Routine
//
//  Created by Mostafa Junayed on 5/14/22.
//

import SwiftUI



struct ContentView: View {
    
    @Environment (\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var routines: FetchedResults<Routine>
    
    var body: some View {
        let currDate: String = getCurrDate()
        NavigationView{
            VStack{
                List(routines) { elem in
                    var tempSet: Set<String> = elem.day ?? Set<String>()
                    if tempSet.contains(currDate.lowercased()){
                        Text(elem.name ?? "unknown")
                    }
                    
                    
                }
                
                
                NavigationLink(destination: SelectingRoutineView()) {
                    Text("Add a routine")
                }
                Text("hello world")
                
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(currDate)
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                    }
                }
                
            }
        }
    }
    
    
    func getCurrDate() -> String{
        let df = DateFormatter()
        df.dateFormat = "EEEE"
        let currDay = df.string(from: Date())
        return currDay
    }
}

// this view allows us to add a routine to the core data model
struct SelectingRoutineView : View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment (\.managedObjectContext) var moc
  
    @State var routine: String = ""
    @State var dates: [DatePick] = [
        DatePick(day: "monday"),
        DatePick(day: "tuesday"),
        DatePick(day: "wednesday"),
        DatePick(day: "thrusday"),
        DatePick(day: "friday"),
        DatePick(day: "saturday"),
        DatePick(day: "sunday")
    ]
    
    
    var body: some View {
        NavigationView {
            VStack{
                ScrollView(.horizontal){
                    HStack{
                        
                        ForEach(0..<dates.count) { i in
                            Button(action:{
                                dates[i].Selected = dates[i].Selected ? false : true
                            }) {
                                VStack{
                                    
                                    Text(shortForm(day1:dates[i].day))
                                    if dates[i].Selected {
                                        Image(systemName: "circle")
                                            .foregroundColor(.green)
                                            .background(.green)
                                            .cornerRadius(1000)
                                        
                                    }
                                    else {
                                        Image(systemName: "circle")
                                    }
                                }.padding(9)
                            }
                        }
                    } // end of Date Picker Hstack
                }
                .background(.red.opacity(0.9))
                
                
                TextField("Add your routine here", text: $routine)
                    .padding()
                    .background(Color.gray.opacity(0.4).cornerRadius(50))
                    
                
                Spacer()
//                test0 strt

//                test0 end
                
                HStack{
                    Button(
                        "Cancel",
                        action: {self.presentationMode.wrappedValue.dismiss()}
                    ).padding()
                    
                    Button("Save", action:{
                        Task{
                            let entity = Routine(context: moc)
                            var daySet: Set<String> = Set<String>()
                            var check: Bool = false
                            for date in dates {
                                if date.Selected && routine.count != 0{
                                    check = true
                                    daySet.insert(date.day)
                                }
                            }
                            if(check &&  routine.count != 0){
                                entity.day = daySet
                                entity.name = routine
                                try? moc.save()
                            }
                            
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    }
                } // end of Vstack
            } // end of Nav View
            .navigationBarHidden(true)
            .navigationBarTitle("hello")
        }
        
        
    
//    func addToCoreData(day1: String, name: String) {
//        let rout = Student(context: self.moc)
//        rout.name = name
//        rout.day = day1
//        try? self.moc.save()
//    }
    
    func shortForm(day1: String) -> String{
        var sf: String = ""
        if day1 == "monday" {
            sf = "mon"
        }
        else if day1 == "tuesday" {
            sf = "tues"
        }
        else if day1 == "wednesday" {
            sf = "wed"
        }
        else if day1 == "thrusday" {
            sf = "thrus"
        }
        else if day1 == "friday" {
            sf = "fri"
        }
        else if day1 == "saturday" {
            sf = "sat"
        }
        else if day1 == "sunday" {
            sf = "sun"
        }
        return sf
    }
}

struct DatePick {
    var day: String
    var Selected: Bool = false
    var sf: String = ""
}

// shows all the view starting from the root
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
