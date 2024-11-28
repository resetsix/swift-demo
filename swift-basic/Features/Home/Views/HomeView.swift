import SwiftUI

struct HomeView: View {
    @State var showPeople = false
    @State private var text = ""
    @State private var password = ""
    @State private var value = 10.0
    @State private var selectDate = Date()
    @State private var count = 2
    @State private var isOn = false
    @State private var progress = 0.5
    @State private var selectedValue = 0

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            // 普通文本
            Text("Hello, world!")
            // 操作按钮
            Button("点击我") {
                print("button1 clicked")
            }
            Button(action: {
                print("button2 clicked")
            }, label: {
                Image(systemName: "clock")
                Text("Click Me")
                Text("Subtitle")
            })
            .foregroundColor(Color.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(5)
            // 列表
//            List(0..<3) { _ in
//                Text("你好")
//            }
            // 图片
//            Image("test")
            // 常规输入框
            TextField("输入你的爱好", text: $text).frame(width: 200)
            // 密码输入框
            SecureField("输入你的密码", text: $password)
            // 开关
            Toggle("开关", isOn: $isOn)
            // 范围选择器
            Slider(value: $value, in: 0...20)
            // 增加或减少数值
            Stepper("Count: \(count)", onIncrement: {
                count += 1
            }, onDecrement: {
                count -= 1
            })
            // 时间选择器
            DatePicker("select a date", selection: $selectDate)
            // 页面导航
            NavigationView {
                NavigationLink(destination: Text("你好")) {
                    Text("detail page")
                }.navigationTitle("导航标题")
            }
            NavigationView {
                List {
                    NavigationLink(destination: Text("导航详情")) {
                        Text("导航项")
                    }.navigationBarTitle(Text("导航标题"))
                }
            }
//            NavigationView {
//                Text("SwiftUI")
//                    .toolbar {
//                        ToolbarItem(placement: .principal) {
//                            HStack {
//                                Text("Title")
//                                Button("Clickable Subtitle") { print("principle") }
//                            }
//                        }
//                    }
//            }
//            NavigationView {
//                Form {
//                    Section {
//                        Picker(
//                            selection: Text("Picker Name"),
//                            label: Text("Picker Name"),
//                            content: {
//                                Text("Value 1").tag(0)
//                                Text("Value 2").tag(1)
//                                Text("Value 3").tag(2)
//                                Text("Value 4").tag(3)
//                            }
//                        )
//                    }
//                }
//            }
            NavigationView {
                Form {
                    Section {
                        Picker(selection: $selectedValue, label: Text("Picker Name")) { // 传递绑定值
                            Text("Value 1").tag(0)
                            Text("Value 2").tag(1)
                            Text("Value 3").tag(2)
                            Text("Value 4").tag(3)
                        }
                    }
                }
            }
            VStack {
                ProgressView(value: progress)
                Button("More", action: { progress -= 0.05 })
            }
            HStack(alignment: .center, spacing: 20) {
                Text("Hello")
                Divider()
                Text("World")
            }
        }
    }
}

#Preview("控件示例") {
    HomeView()
}
