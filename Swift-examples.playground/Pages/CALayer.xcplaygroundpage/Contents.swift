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








