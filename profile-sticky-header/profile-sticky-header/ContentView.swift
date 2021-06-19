//
//  ContentView.swift
//  profile-sticky-header
//
//  Created by Alked Ejupi on 19/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var tab : Int = 0
    @Namespace var animation
    //offset
    
    @State var topHeaderOffset : CGFloat
    
    
    fileprivate func StatView(_ statName: String, _ stat: Int) -> some View {
        return VStack {
            Text(stat.description).font(Font.body.weight(.black))
            Text(statName).font(Font.body.weight(.medium)).foregroundColor(.secondary)
        }.padding()
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                    Button(action: {
                        print("Edit profile logic..")
                    }){
                        Image("avatar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .clipShape(Circle())
                    }

                    Spacer()
                    StatView("Posts", 10)
                    StatView("Likes", 294)
                    StatView("Followers", 200)
                    Spacer()


                }.padding(.horizontal).padding(.top)
                
                VStack(spacing:3){
                    HStack{
                        Text("Alked Ejupi").font(.headline.weight(.bold))
                        Spacer()
                    }
                    HStack{
                        Text("SwiftUI developer").font(.headline.weight(.regular))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    
                    HStack{
                        Text("This is a demo to show a profile with sticky tabs.").font(.body.weight(.regular))
                            .foregroundColor(.primary)
                        Spacer()
                    }


                }.padding()
                
                
                HStack(spacing: 0) {
                    TabBarButton(idTab: 0, icon: "square.grid.3x3", animation: animation, selectedTab: self.$tab)
                    TabBarButton(idTab: 1, icon: "tropicalstorm", animation: animation, selectedTab: self.$tab)
                    TabBarButton(idTab: 2, icon: "plus.bubble", animation: animation, selectedTab: self.$tab)
                }.frame(height:70, alignment: .bottom)
                .overlay(
                    
                    GeometryReader{proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        DispatchQueue.main.async {
                            if topHeaderOffset == 0 {
                                topHeaderOffset = minY
                            }
                        }
                        
                        return Color.clear
                    }.frame(width: 0, height: 0)
                
                )
                
                
                if tab == 0 {
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2),count: 3), spacing: 3, content: {
                    
                    ForEach(1...50, id: \.self) { index in
                     Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    }

                })
                    
                } else {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2),count: 3), spacing: 3, content: {
                        
                        ForEach(1...2, id: \.self) { index in
                         Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                           
                        
                        }

                    })
                    
                }
              

            }.navigationBarTitle("Sticky header", displayMode: .inline)
            
        }
        
        

    }
}


struct TabBarButton : View {
    
    var idTab : Int
    var icon : String
    var animation : Namespace.ID
    @Binding var selectedTab : Int
    
    var body: some View {
        Button(action: {
            
            withAnimation(.easeInOut) {
                self.selectedTab = idTab
            }
            
        }) {
            VStack{
            Image(systemName: icon)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(selectedTab == idTab ? .primary : .secondary)
            
        
                ZStack{
                    if selectedTab == idTab {
                        Rectangle()
                            .fill(Color.primary)
                            .frame(height: 1)
                            .matchedGeometryEffect(id: "TAB", in: animation)

                    } else{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 1)


                    }
                }
                
            }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
