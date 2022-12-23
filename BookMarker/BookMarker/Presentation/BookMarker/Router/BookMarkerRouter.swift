//
//  BookMarkerRouter.swift
//  BookMarker
//
//  Created by Nunu Nugraha on 08/10/22.
//

import SwiftUI

class BookMarkerRouter {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    private var viewController: UIViewController? {
        self.viewControllerHolder
    }
    
    func toAddView(addView: AddView) {
        self.viewController?.present {
            addView
        }
    }
    
    func toListArchive() -> some View {
        var viewModel = ListViewPresenter()
        return ListArchiveView(viewModel: viewModel)
    }
}
