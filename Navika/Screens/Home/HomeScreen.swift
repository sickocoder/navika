//
//  HomeScreen.swift
//  Navika
//
//  Created by A255085 on 05/08/24.
//

import SwiftUI
import Lottie

struct HomeScreen: View {
  @EnvironmentObject var habitSettings: HabitSettings
  @Environment(AppRouting.self) private var route
  
  @Binding var shouldHideTabBar: Bool
  
  @State var isLoadingHabits: Bool = true
  @State var progress: CGFloat = 0
  @State var isScrollingUp: Bool = false
  
  @State var showCalendarView: Bool = false
  
  var body: some View {
    NAContainerView {
      ScrollView(.vertical, showsIndicators: false) {
        LazyVStack(alignment: .leading, spacing: 0) {
          if habitSettings.habitList.count > 0 {
            ForEach(habitSettings.habitList) { habit in
              HabitCard(habit: habit)
                .onTapGesture {
                  route.append(route: .authenticated(.habit(habit)))
                }
            }
          } else {
            if isLoadingHabits {
              /// MARK: - Handle loadins state
            } else {
              EmptyList(label: "No habits set")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 55 + 80)
            }
          }
        }
        .frame(minHeight: UIScreen.main.bounds.height * 0.7, alignment: habitSettings.habitList.count > 0 ? .top : .center)
        .padding(.bottom, 55 + 80)
        .background(.white)
        .cornerRadius(40 * (1 - self.progress))
        .overlay(content: {
          RoundedRectangle(cornerRadius: 40 * (1 - self.progress))
            .stroke(.gray.opacity(0.5), lineWidth: 1)
        })
        .offset(y: progress * 55)
        .safeAreaInset(edge: .top, spacing: 0) {
          ResizableHeader()
        }
      }
      .onScrollGeometryChange(for: CGFloat.self) { scrollGeometry in
        scrollGeometry.contentOffset.y + scrollGeometry.contentInsets.top
      } action: { oldValue, newValue in
        progress = max(min(newValue / 55, 1), 0)
        
        isScrollingUp = oldValue < newValue
      }
      .onAppear {
        Task {
          do {
            let habits: [HabitModel] = try await FirestoreHelper.shared.getDocuments(from: .habits)
            
            withAnimation {
              isLoadingHabits = false
              self.habitSettings.habitList = habits
            }
          } catch {
            /// MARK: - TODO: handle error
            isLoadingHabits = false
          }
        }
      }
    }
  }
  
  nonisolated private func offsetY(_ proxy: GeometryProxy) -> CGFloat {
    let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
    return minY > 0 ? 0 : -minY
  }
  
  func setSelectedWeekDay(weekDay: WeekDaysViewDateModel) {
    self.habitSettings.weekDay = weekDay
  }
  
  func toggleToolbar() {
    withAnimation {
      shouldHideTabBar.toggle()
    }
  }
  
  func onShowCalendarPressed() {
    withAnimation {
      showCalendarView.toggle()
    }
  }
  
  @ViewBuilder func ResizableHeader() -> some View {
    VStack {
      Header(
        scrollProgress: progress,
        onWeekDayPress: setSelectedWeekDay,
        onCreateHabitPress: toggleToolbar,
        onViewCalendarPress: onShowCalendarPressed
      )
      .padding(.bottom)
      .background {
        Color.defaultBackground
          .padding(.horizontal, -15)
          .padding(.top, -100)
      }
      .overlay(Divider().frame(height: 2 * self.progress).opacity(self.progress >= 1.0 ? 1 : 0), alignment: .bottom)
      .visualEffect { content, proxy in
        content.offset(y: self.offsetY(proxy))
      }
    }
  }
}


#Preview {
  //  HomeScreen(shouldHideTabBar: .constant(false))
  ContentView()
    .environmentObject(HabitSettings())
    .environment(AppRouting())
}




