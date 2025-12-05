package com.sxd.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 自定义权限注解，用于标记Controller方法需要的权限
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RequiredPermission {
    /**
     * 权限名称
     */
    String value() default "";
    
    /**
     * 权限描述
     */
    String description() default "";
}