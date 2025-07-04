// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --version 2
// RUN: %clang_cc1 -triple loongarch64 -emit-llvm -o - %s | FileCheck %s
// RUN: %clang_cc1 -triple loongarch32 -emit-llvm -o - %s | FileCheck %s

// CHECK-LABEL: define dso_local void @_Z3fooDF16b
// CHECK-SAME: (bfloat noundef [[B:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-NEXT:  entry:
// CHECK-NEXT:    [[B_ADDR:%.*]] = alloca bfloat, align 2
// CHECK-NEXT:    store bfloat [[B]], ptr [[B_ADDR]], align 2
// CHECK-NEXT:    ret void
//
void foo(__bf16 b) {}
