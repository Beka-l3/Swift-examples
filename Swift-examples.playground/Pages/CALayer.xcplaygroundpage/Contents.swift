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


