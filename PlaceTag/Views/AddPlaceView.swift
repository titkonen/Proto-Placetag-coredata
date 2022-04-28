import SwiftUI

enum Mood: String {
  case happy = "😀"
  case sad = "☹️"
  case upsidedown = "🙃"
  case cat = "🐱"
}

struct AddPlaceView: View {
	@State private var title: String = ""
	@State private var note: String = ""
	@State private var image: UIImage?
	@State private var shouldShowImagePicker = false

	@Environment(\.managedObjectContext) private var viewContext
	@Environment(\.presentationMode) private var presentationMode

  // MARK: Properties for StatusControl
  @State private var name: String = ""
  @State private var favoriteColor: Color = .green
  @State private var mood: Mood = .happy
  
	var body: some View {
    VStack() {
      Form {
        Section(header: Text("Title")) {
          TextField("Insert place title here", text: $title)
            .autocapitalization(.words)
        }
        Section(header: Text("Notes")) {
          TextField("Insert notes about the place here", text: $note)
            .autocapitalization(.sentences)
        }
        Section {
          Button(
            action: {
              shouldShowImagePicker.toggle()
            },
            label: makeImageForChoosePhotosButton
          )
        }
        
        Button(
          action: {
            Place.create(title: title, note: note, image: image, context: viewContext)
            presentationMode.wrappedValue.dismiss()
          },
          label: {
            HStack {
              Image(systemName: "square.and.arrow.down.fill")
              Text("Save Place")
            }
          }
        )
        .buttonStyle(ActionButtonBackgroundStyle())
        
        Text("Set your status:")
        
        StatusControl(name: $name, favoriteColor: $favoriteColor, mood: $mood)
        
        StatusIcon(name: name, favoriteColor: favoriteColor, mood: mood)
          .padding()
        
      } /// .Form
      .navigationBarTitle("Add Place")
      .sheet(isPresented: $shouldShowImagePicker) {
        ImagePicker(image: $image)
      }
        
      
      
      } /// .VStack
      
      
      
} /// .body
    

	@ViewBuilder
  private func makeImageForChoosePhotosButton() -> some View {
		image.map {
			Image(uiImage: $0)
				.renderingMode(.original)
				.resizable()
				.aspectRatio(contentMode: .fill)
		}

		if image == nil {
			HStack {
				Spacer()
				Image(systemName: "photo.on.rectangle")
				Text("Choose Photo")
				Spacer()
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
		}
	}
}

struct AddPlaceView_Previews: PreviewProvider {
	static var previews: some View {
		AddPlaceView()
	}
}

// MARK: Component StatusControl
struct StatusControl: View {
  @Binding var name: String
  @Binding var favoriteColor: Color
  @Binding var mood: Mood
  
  var body: some View {
    VStack {
      TextField("Name", text: $name)
        .textFieldStyle(RoundedBorderTextFieldStyle())
      
      ColorPicker("Favorite Color", selection: $favoriteColor)
      
      Picker("Mood", selection: $mood) {
        Text(Mood.happy.rawValue).tag(Mood.happy)
        Text(Mood.sad.rawValue).tag(Mood.sad)
        Text(Mood.upsidedown.rawValue).tag(Mood.upsidedown)
        Text(Mood.cat.rawValue).tag(Mood.cat)
      }
      .pickerStyle(SegmentedPickerStyle())
    }
  }
}

// MARK: Component StatusIcon
struct StatusIcon: View {
  let name: String
  let favoriteColor: Color
  let mood: Mood
  
  var body: some View {
    VStack {
      Text(mood.rawValue)
      Text(name)
        .foregroundColor(.white)
    }
    .font(.largeTitle)
    .padding()
    .background(favoriteColor)
    .cornerRadius(12)
  }
}




//    ZStack(alignment: .bottomTrailing) {
//      Form {
//        Section(header: Text("Title")) {
//          TextField("Insert place title here", text: $title)
//            .autocapitalization(.words)
//        }
//        Section(header: Text("Notes")) {
//          TextField("Insert notes about the place here", text: $note)
//            .autocapitalization(.sentences)
//        }
//        Section {
//          Button(
//            action: {
//              shouldShowImagePicker.toggle()
//            },
//            label: makeImageForChoosePhotosButton
//          )
//        }
//
//      } /// .Form
      

//        Text("Set your status:")
