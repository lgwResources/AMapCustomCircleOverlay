//
//  ObjectSingleton.h
//  CarUtopia
//
//  Created by 刘功武 on 2020/9/30.
//

#ifndef ObjectSingleton_h
#define ObjectSingleton_h

#define OBJECT_SINGLETON_BOILERPLATE(_object_name_, _shared_obj_name_) \
static _object_name_ *z##_shared_obj_name_ = nil;  \
+ (_object_name_ *)_shared_obj_name_ {             \
@synchronized(self) {                            \
if (z##_shared_obj_name_ == nil) {             \
static dispatch_once_t done;\
dispatch_once(&done, ^{ z##_shared_obj_name_ = [[self alloc] init]; });\
}\
}                                                \
return z##_shared_obj_name_;                     \
}                                                  \
+ (id)allocWithZone:(NSZone *)zone {               \
@synchronized(self) {                            \
if (z##_shared_obj_name_ == nil) {             \
z##_shared_obj_name_ = [super allocWithZone:NULL]; \
return z##_shared_obj_name_;                 \
}                                              \
}                                                \
\
return nil;                                    \
}

#endif /* ObjectSingleton_h */
