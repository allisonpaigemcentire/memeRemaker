//
//  MemeTextField.swift
//  memeRemaker
//
//  Created by Allison Mcentire on 9/5/22.
//
import SwiftUI

public struct MemeTextField: View {
  var titleKey: LocalizedStringKey
  @Binding var text: String

  /// Whether the user is focused on this `TextField`.
  @State private var isEditing: Bool = false

  public init(_ titleKey: LocalizedStringKey, text: Binding<String>) {
    self.titleKey = titleKey
    self._text = text
  }

  public var body: some View {
    TextField(titleKey, text: $text, onEditingChanged: { isEditing = $0 })
      // Make sure no other style is mistakenly applied.
      .textFieldStyle(PlainTextFieldStyle())
      // Text alignment.
      .multilineTextAlignment(.leading)
      // Cursor color.
      .accentColor(.black)
      // Text color.
      .foregroundColor(.blue)
      // Text/placeholder font.
      .font(.title.weight(.semibold))
      // TextField spacing.
      .padding(.vertical, 12)
      .padding(.horizontal, 16)
      // TextField border.
      .background(border)
  }

  var border: some View {
    RoundedRectangle(cornerRadius: 16)
      .strokeBorder(
        LinearGradient(
          gradient: .init(
            colors: [
                .red,
                .blue
            ]
          ),
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        ),
        lineWidth: isEditing ? 4 : 2
      )
  }
}
