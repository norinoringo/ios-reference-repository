//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 7 storyboards.
  struct storyboard {
    /// Storyboard `Home`.
    static let home = _R.storyboard.home()
    /// Storyboard `NextViewFromTableView`.
    static let nextViewFromTableView = _R.storyboard.nextViewFromTableView()
    /// Storyboard `ScrollView`.
    static let scrollView = _R.storyboard.scrollView()
    /// Storyboard `Splash`.
    static let splash = _R.storyboard.splash()
    /// Storyboard `TestUICollectionView`.
    static let testUICollectionView = _R.storyboard.testUICollectionView()
    /// Storyboard `TestUITableView`.
    static let testUITableView = _R.storyboard.testUITableView()
    /// Storyboard `Top`.
    static let top = _R.storyboard.top()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Home", bundle: ...)`
    static func home(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.home)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "NextViewFromTableView", bundle: ...)`
    static func nextViewFromTableView(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.nextViewFromTableView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "ScrollView", bundle: ...)`
    static func scrollView(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.scrollView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Splash", bundle: ...)`
    static func splash(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.splash)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "TestUICollectionView", bundle: ...)`
    static func testUICollectionView(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.testUICollectionView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "TestUITableView", bundle: ...)`
    static func testUITableView(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.testUITableView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Top", bundle: ...)`
    static func top(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.top)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    /// Color `AccentColor`.
    static let accentColor = Rswift.ColorResource(bundle: R.hostingBundle, name: "AccentColor")

    #if os(iOS) || os(tvOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(tvOS 11.0, *)
    @available(iOS 11.0, *)
    static func accentColor(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIColor? {
      return UIKit.UIColor(resource: R.color.accentColor, compatibleWith: traitCollection)
    }
    #endif

    #if os(watchOS)
    /// `UIColor(named: "AccentColor", bundle: ..., traitCollection: ...)`
    @available(watchOSApplicationExtension 4.0, *)
    static func accentColor(_: Void = ()) -> UIKit.UIColor? {
      return UIKit.UIColor(named: R.color.accentColor.name)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.image` struct is generated, and contains static references to 2 images.
  struct image {
    /// Image `pop_sold_out`.
    static let pop_sold_out = Rswift.ImageResource(bundle: R.hostingBundle, name: "pop_sold_out")
    /// Image `sarunori`.
    static let sarunori = Rswift.ImageResource(bundle: R.hostingBundle, name: "sarunori")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "pop_sold_out", bundle: ..., traitCollection: ...)`
    static func pop_sold_out(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pop_sold_out, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "sarunori", bundle: ..., traitCollection: ...)`
    static func sarunori(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sarunori, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.info` struct is generated, and contains static references to 1 properties.
  struct info {
    struct uiApplicationSceneManifest {
      static let _key = "UIApplicationSceneManifest"
      static let uiApplicationSupportsMultipleScenes = false

      struct uiSceneConfigurations {
        static let _key = "UISceneConfigurations"

        struct uiWindowSceneSessionRoleApplication {
          struct defaultConfiguration {
            static let _key = "Default Configuration"
            static let uiSceneConfigurationName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneConfigurationName") ?? "Default Configuration"
            static let uiSceneDelegateClassName = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneDelegateClassName") ?? "$(PRODUCT_MODULE_NAME).SceneDelegate"
            static let uiSceneStoryboardFile = infoPlistString(path: ["UIApplicationSceneManifest", "UISceneConfigurations", "UIWindowSceneSessionRoleApplication", "Default Configuration"], key: "UISceneStoryboardFile") ?? "Splash"

            fileprivate init() {}
          }

          fileprivate init() {}
        }

        fileprivate init() {}
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 6 nibs.
  struct nib {
    /// Nib `TestCollectionFooterView`.
    static let testCollectionFooterView = _R.nib._TestCollectionFooterView()
    /// Nib `TestCollectionHeaderView`.
    static let testCollectionHeaderView = _R.nib._TestCollectionHeaderView()
    /// Nib `TestCollectionViewCell`.
    static let testCollectionViewCell = _R.nib._TestCollectionViewCell()
    /// Nib `TestUITableViewCell`.
    static let testUITableViewCell = _R.nib._TestUITableViewCell()
    /// Nib `TopViewCell`.
    static let topViewCell = _R.nib._TopViewCell()
    /// Nib `TopViewHeader`.
    static let topViewHeader = _R.nib._TopViewHeader()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TestCollectionFooterView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.testCollectionFooterView) instead")
    static func testCollectionFooterView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.testCollectionFooterView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TestCollectionHeaderView", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.testCollectionHeaderView) instead")
    static func testCollectionHeaderView(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.testCollectionHeaderView)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TestCollectionViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.testCollectionViewCell) instead")
    static func testCollectionViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.testCollectionViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TestUITableViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.testUITableViewCell) instead")
    static func testUITableViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.testUITableViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TopViewCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.topViewCell) instead")
    static func topViewCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.topViewCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "TopViewHeader", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.topViewHeader) instead")
    static func topViewHeader(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.topViewHeader)
    }
    #endif

    static func testCollectionFooterView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UICollectionReusableView? {
      return R.nib.testCollectionFooterView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UICollectionReusableView
    }

    static func testCollectionHeaderView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UICollectionReusableView? {
      return R.nib.testCollectionHeaderView.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UICollectionReusableView
    }

    static func testCollectionViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestCollectionViewCell? {
      return R.nib.testCollectionViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestCollectionViewCell
    }

    static func testUITableViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestUITableViewCell? {
      return R.nib.testUITableViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestUITableViewCell
    }

    static func topViewCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopViewCell? {
      return R.nib.topViewCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopViewCell
    }

    static func topViewHeader(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopViewHeader? {
      return R.nib.topViewHeader.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopViewHeader
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 1 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `TopViewCell`.
    static let topViewCell: Rswift.ReuseIdentifier<TopViewCell> = Rswift.ReuseIdentifier(identifier: "TopViewCell")

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _TestCollectionViewCell.validate()
    }

    struct _TestCollectionFooterView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TestCollectionFooterView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UICollectionReusableView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UICollectionReusableView
      }

      fileprivate init() {}
    }

    struct _TestCollectionHeaderView: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TestCollectionHeaderView"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> UIKit.UICollectionReusableView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UICollectionReusableView
      }

      fileprivate init() {}
    }

    struct _TestCollectionViewCell: Rswift.NibResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "TestCollectionViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestCollectionViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestCollectionViewCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "pop_sold_out", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'pop_sold_out' is used in nib 'TestCollectionViewCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    struct _TestUITableViewCell: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TestUITableViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TestUITableViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TestUITableViewCell
      }

      fileprivate init() {}
    }

    struct _TopViewCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = TopViewCell

      let bundle = R.hostingBundle
      let identifier = "TopViewCell"
      let name = "TopViewCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopViewCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopViewCell
      }

      fileprivate init() {}
    }

    struct _TopViewHeader: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "TopViewHeader"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> TopViewHeader? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? TopViewHeader
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try home.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try nextViewFromTableView.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try scrollView.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try splash.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try testUICollectionView.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try testUITableView.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try top.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct home: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = HomeViewController

      let bundle = R.hostingBundle
      let name = "Home"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct nextViewFromTableView: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = NextViewControllerFromTableView

      let bundle = R.hostingBundle
      let name = "NextViewFromTableView"
      let nextViewFromTableView = StoryboardViewControllerResource<NextViewControllerFromTableView>(identifier: "nextViewFromTableView")

      func nextViewFromTableView(_: Void = ()) -> NextViewControllerFromTableView? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: nextViewFromTableView)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.nextViewFromTableView().nextViewFromTableView() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'nextViewFromTableView' could not be loaded from storyboard 'NextViewFromTableView' as 'NextViewControllerFromTableView'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct scrollView: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ScrollViewController

      let bundle = R.hostingBundle
      let name = "ScrollView"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct splash: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SplashViewController

      let bundle = R.hostingBundle
      let name = "Splash"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct testUICollectionView: Rswift.StoryboardResourceType, Rswift.Validatable {
      let bundle = R.hostingBundle
      let name = "TestUICollectionView"
      let testUICollectionView = StoryboardViewControllerResource<TestUICollectionViewController>(identifier: "TestUICollectionView")

      func testUICollectionView(_: Void = ()) -> TestUICollectionViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: testUICollectionView)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.testUICollectionView().testUICollectionView() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'testUICollectionView' could not be loaded from storyboard 'TestUICollectionView' as 'TestUICollectionViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct testUITableView: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = TestUITableViewController

      let bundle = R.hostingBundle
      let name = "TestUITableView"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct top: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Top"

      static func validate() throws {
        if #available(iOS 13.0, *) { if UIKit.UIImage(systemName: "house") == nil { throw Rswift.ValidationError(description: "[R.swift] System image named 'house' is used in storyboard 'Top', but couldn't be loaded.") } }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
