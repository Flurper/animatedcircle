import SwiftUI

struct ContentView: View {
    
    private struct AnimationData: Equatable {
        
        let offSet: CGSize
        let color: Color
        
        static let array: [Self] = [
            .init(offSet: .init(width: 0, height: 0),
                  color: .green),
            .init(offSet: .init(width: 100, height: 0),
                  color: .yellow),
            .init(offSet: .init(width: 100, height: -100),
                  color: .red),
            .init(offSet: .init(width: -100, height: -100),
                  color: .blue),
            .init(offSet: .init(width: -100, height: 0),
                  color: .orange)
        ]
    }
    
    @State private var animatedData = AnimationData.array[0]
    
    var body: some View {
        Circle()
            .scaleEffect(0.5)
            .foregroundColor(animatedData.color)
            .offset(animatedData.offSet)
            .onAppear {
                animationLoop(loop: 10)
            }
    }
    private func animationLoop(loop: Int) {
        guard loop > 0 else { return }
        for (index, data) in AnimationData.array.enumerated().dropFirst() {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(index)) {
                animatedData = data
                if index == AnimationData.array.count - 1 {
                    animationLoop(loop: loop - 1)
                }
            }
        }
            }
    }

#Preview {
    ContentView()
}
