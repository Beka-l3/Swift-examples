import UIKit


/// Layers are often used to provide the backing store for views but can also be used without a view to display content.
/// A layer’s main job is to manage the visual content that you provide but the layer itself has visual attributes that can be set,
/// such as a background color, border, and shadow. In addition to managing visual content, the layer also maintains information about
/// the geometry of its content (such as its position, size, and transform) that is used to present that content onscreen.

/// Modifying the properties of the layer is how you initiate animations on the layer’s content or geometry.
/// A layer object encapsulates the duration and pacing of a layer and its animations by adopting the `CAMediaTiming` protocol, which defines the layer’s timing information.

/// If the layer object was created by a view, the view typically assigns itself as the layer’s `delegate` automatically, and you should not change that relationship.
/// For layers you create yourself, you can assign a delegate object and use that object to provide the contents of the layer dynamically and perform other tasks.
/// A layer may also have a layout manager object (assigned to the layoutManager property) to manage the layout of subviews separately.

/// they have: `Bounds`, `Frame`, `Anchor Point`, `Position`




// MARK: - Layers Can Be Manipulated in Three Dimensions
/// Every layer has two transform matrices that you can use to manipulate the layer and its contents.
/// The transform property of CALayer specifies the transforms that you want to apply both to the layer and its embedded sublayers.

/// Normally you use this property when you want to modify the layer itself.
/// For example, you might use that property to scale or rotate the layer or change its position temporarily.
/// The `sublayerTransform` property defines additional transformations that apply only to the sublayers and
/// is used most commonly to add a perspective visual effect to the contents of a scene.

/*
 
 x      m11  m12  m13  m14     x'
 y  *   m21  m22  m23  m24  =  y'
 z      m31  m32  m33  m34     z'
 1      m41  m42  m43  m44     1
 
 */

/// `Identity`          `translate`             `scale`
/// 1 0 0 0                           1 0 0 0                      sx 0 0 0
/// 0 1 0 0                           0 1 0 0                      0 sy 0 0
/// 0 0 1 0                           0 0 1 0                      0 0 sz 0
/// 0 0 0 1                          tx ty tz 1                     0 0 0  1

/// `Rotate around X`
///   1     0    0    0
///   0 cosx sinx 0
///   0 -sinx cosx 0
///   0     0    0    1

/// `Rotate around Y`
///   cosx 0 -sinx 0
///   0      1     0   0
///   sinx  0 cosx 0
///   0     0    0    1

/// `Rotate around Z`
///   cosx sinx  0 0
///   -sinx cosx 0 0
///   0     0    1     0
///   0     0    0     1




// MARK: - Layer Trees Reflect Different Aspects of the Animation State
/// An app using `Core Animation` has `three` `sets` of layer objects.
/// Each set of layer objects has a different role in making the content of your app appear onscreen

// MARK: Model layer tree
/// Objects in the model layer tree (or simply `layer tree`) are the ones your app interacts with the most.
/// The objects in this tree are the model objects that store the ``target values`` for any animations.
/// Whenever you change the property of a layer, you use one of these objects.

// MARK: Presentation tree
/// Objects in the presentation tree contain the in-flight values for any `running animations`.
/// Whereas the layer tree objects contain the target values for an animation,
/// the objects in the presentation tree reflect the ``current values`` as they appear onscreen.
/// You should `never modify` the objects in this tree.
/// Instead, you use these objects to `read` current animation values, perhaps to create a new animation starting at those values.

// MARK: Render tree
/// Objects in the render tree `perform` the actual `animations` and are `private` to Core Animation


/// for an app that enables layers for all of its views, the initial structure of each tree matches the structure of the view hierarchy exactly

/// For every object in the layer tree, there is a matching object in the presentation and render trees.
/// As was previously mentioned, apps primarily work with objects in the layer tree but may at times access objects in the presentation tree.
/// Specifically, accessing the `presentationLayer` property of an object in the layer tree returns the corresponding object in the presentation tree.
/// You might want to access that object to read the current value of a property that is in the middle of an animation.

/// `Important`: You should access objects in the presentation tree only while an animation is in flight.
/// While an animation is in progress, the presentation tree contains the layer values as they appear onscreen at that instant.
/// This behavior differs from the layer tree, which always reflects the last value set by your code and is equivalent to the final state of the animation.




// MARK: - The Relationship Between Layers and Views
/// Layers are not a replacement for your app’s views—that is, you cannot create a visual interface based solely on layer objects.

/// Layers provide infrastructure for your views.
/// Specifically, layers make it easier and more efficient to draw and animate the contents of views and maintain high frame rates while doing so.

/// However, there are many things that layers do not do.
/// ``Layers do not handle events, draw content, participate in the responder chain, or do many other things``

/// For this reason, every app must still have one or more views to handle those kinds of interactions.

/// In a ``layer-backed view``, the system is responsible for creating the underlying layer object and for keeping that layer in sync with the view.
/// All iOS views are layer-backed

/// `Note`: For layer-backed views, it is recommended that you manipulate the view, rather than its layer, whenever possible.
/// In iOS, views are just a thin wrapper around layer objects, so any manipulations you make to the layer usually work just fine.
/// But there are cases in both iOS and OS X where manipulating the layer instead of the view might not yield the desired results.
/// Wherever possible, this document points out those pitfalls and tries to provide ways to help you work around them.

/// n addition to the layers associated with your views, you can also create layer objects that do not have a corresponding view.
/// You can embed these standalone layer objects inside of any other layer object in your app, including those that are associated with a view.
/// You typically use standalone layer objects as part of a specific `optimization` path.

/// `For example`, if you wanted to use the same image in multiple places,
/// you could load the image once and associate it with multiple standalone layer objects and add those objects to the layer tree.
/// Each layer then refers to the source image rather than trying to create its own copy of that image in memory


// MARK: - Animation
/// CALayer has UIView as a delegate
/// when property changed, it calls ``action(for: forKey:)`` to get info about animation
/// if that code black is not in the `UIView.animate` then it returns `nil`
/// otherwise it returns pararmeters from `UIView.animate`
/// if CALayer has no delegate, that it uses default paramaeters from it's action dictionary
/// Changing `view.layer.frame` affects `view.frame`, and otherway

// MARK: IMPORTANT
/// UIView can be a `delegate` `only` for ``1`` layer.
/// Even programmatically it can be delegate for more than 1. Animations will not work and will lead to crash



// MARK: Hierachy
/// When `myView` is add as an subiew to the `view`
/// layer of `myView` is added as an sublayer to the `view.layer` <<under the hood>>


// CAAnimation: it is an protocol fro animations
/// You can create your own class that conforms to this protocol
/// Or use existing classes:
/// - `CABasicAnimation`: basic animation, with interpolation value between `fromPoint` and `toPoint`
/// - `CAKeyFrameAnimation`: animation, with interpolation value between two key frames, defined with the help of arrays `values` and `keyTime`
/// - `CASpringAnimation`: spring(bouncing) animation

/// `layer.presentationLayer` is a copy of an layer but with the current values at a time
/// 3 useful cases:
/// 1) **Stop animation**: save current values, then continue if needed. (if animation is deleted, then it uses values from `model tree`)
/// 2) **Seamles animation transition**: to start a new animation, `fromValue` is needed from presentationLayer
/// 3) **Correct interation proccessing of animating element**: during animation `hitTest(_: with: )` <<point(inside: with: )>> will use values from `model tree`. To
///     proccess it correctly we need to `override` `point(_: with: )` to work with `presentationLayer`

/// That is layer returns to it's inital values, if we do not change `layer.isRemovedOnCompletion`.
/// if we set it to `false`, then finishing values from animation is preserved in to the `model tree`

//MARK: note
/// Animtion depends on app lifecycle and layer itself.
/// If an app goes to `background` and layer is deleted from `superview`, then `CAAnimation` is deleted
/// So, if app is switched midway of an animation, then object will be in it;s initial state









