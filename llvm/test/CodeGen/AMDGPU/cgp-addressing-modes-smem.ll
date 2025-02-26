; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc -mtriple=amdgcn -mcpu=gfx600 < %s | FileCheck %s -check-prefixes=GFX6789,GFX678,GFX689,GFX67,GFX6
; RUN: llc -mtriple=amdgcn -mcpu=gfx700 < %s | FileCheck %s -check-prefixes=GFX6789,GFX678,GFX67,GFX7
; RUN: llc -mtriple=amdgcn -mcpu=gfx801 < %s | FileCheck %s -check-prefixes=GFX6789,GFX678,GFX689,GFX89
; RUN: llc -mtriple=amdgcn -mcpu=gfx900 < %s | FileCheck %s -check-prefixes=GFX6789,GFX689,GFX89,GFX9
; RUN: llc -mtriple=amdgcn -mcpu=gfx1200 < %s | FileCheck %s -check-prefixes=GFX12

define amdgpu_cs void @test_sink_smem_offset_400(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX67-LABEL: test_sink_smem_offset_400:
; GFX67:       ; %bb.0: ; %entry
; GFX67-NEXT:  .LBB0_1: ; %loop
; GFX67-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX67-NEXT:    s_waitcnt lgkmcnt(0)
; GFX67-NEXT:    s_load_dword s3, s[0:1], 0x64
; GFX67-NEXT:    s_add_i32 s2, s2, -1
; GFX67-NEXT:    s_cmp_lg_u32 s2, 0
; GFX67-NEXT:    s_cbranch_scc1 .LBB0_1
; GFX67-NEXT:  ; %bb.2: ; %end
; GFX67-NEXT:    s_endpgm
;
; GFX89-LABEL: test_sink_smem_offset_400:
; GFX89:       ; %bb.0: ; %entry
; GFX89-NEXT:  .LBB0_1: ; %loop
; GFX89-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX89-NEXT:    s_waitcnt lgkmcnt(0)
; GFX89-NEXT:    s_load_dword s3, s[0:1], 0x190
; GFX89-NEXT:    s_add_i32 s2, s2, -1
; GFX89-NEXT:    s_cmp_lg_u32 s2, 0
; GFX89-NEXT:    s_cbranch_scc1 .LBB0_1
; GFX89-NEXT:  ; %bb.2: ; %end
; GFX89-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_400:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:  .LBB0_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], 0x190
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB0_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 400
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}

define amdgpu_cs void @test_sink_smem_offset_4000(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX6-LABEL: test_sink_smem_offset_4000:
; GFX6:       ; %bb.0: ; %entry
; GFX6-NEXT:    s_add_u32 s0, s0, 0xfa0
; GFX6-NEXT:    s_addc_u32 s1, s1, 0
; GFX6-NEXT:  .LBB1_1: ; %loop
; GFX6-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX6-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6-NEXT:    s_load_dword s3, s[0:1], 0x0
; GFX6-NEXT:    s_add_i32 s2, s2, -1
; GFX6-NEXT:    s_cmp_lg_u32 s2, 0
; GFX6-NEXT:    s_cbranch_scc1 .LBB1_1
; GFX6-NEXT:  ; %bb.2: ; %end
; GFX6-NEXT:    s_endpgm
;
; GFX7-LABEL: test_sink_smem_offset_4000:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:  .LBB1_1: ; %loop
; GFX7-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s3, s[0:1], 0x3e8
; GFX7-NEXT:    s_add_i32 s2, s2, -1
; GFX7-NEXT:    s_cmp_lg_u32 s2, 0
; GFX7-NEXT:    s_cbranch_scc1 .LBB1_1
; GFX7-NEXT:  ; %bb.2: ; %end
; GFX7-NEXT:    s_endpgm
;
; GFX89-LABEL: test_sink_smem_offset_4000:
; GFX89:       ; %bb.0: ; %entry
; GFX89-NEXT:  .LBB1_1: ; %loop
; GFX89-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX89-NEXT:    s_waitcnt lgkmcnt(0)
; GFX89-NEXT:    s_load_dword s3, s[0:1], 0xfa0
; GFX89-NEXT:    s_add_i32 s2, s2, -1
; GFX89-NEXT:    s_cmp_lg_u32 s2, 0
; GFX89-NEXT:    s_cbranch_scc1 .LBB1_1
; GFX89-NEXT:  ; %bb.2: ; %end
; GFX89-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_4000:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:  .LBB1_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], 0xfa0
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB1_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 4000
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}

define amdgpu_cs void @test_sink_smem_offset_4000000(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX689-LABEL: test_sink_smem_offset_4000000:
; GFX689:       ; %bb.0: ; %entry
; GFX689-NEXT:    s_add_u32 s0, s0, 0x3d0900
; GFX689-NEXT:    s_addc_u32 s1, s1, 0
; GFX689-NEXT:  .LBB2_1: ; %loop
; GFX689-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX689-NEXT:    s_waitcnt lgkmcnt(0)
; GFX689-NEXT:    s_load_dword s3, s[0:1], 0x0
; GFX689-NEXT:    s_add_i32 s2, s2, -1
; GFX689-NEXT:    s_cmp_lg_u32 s2, 0
; GFX689-NEXT:    s_cbranch_scc1 .LBB2_1
; GFX689-NEXT:  ; %bb.2: ; %end
; GFX689-NEXT:    s_endpgm
;
; GFX7-LABEL: test_sink_smem_offset_4000000:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:  .LBB2_1: ; %loop
; GFX7-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s3, s[0:1], 0xf4240
; GFX7-NEXT:    s_add_i32 s2, s2, -1
; GFX7-NEXT:    s_cmp_lg_u32 s2, 0
; GFX7-NEXT:    s_cbranch_scc1 .LBB2_1
; GFX7-NEXT:  ; %bb.2: ; %end
; GFX7-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_4000000:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:  .LBB2_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], 0x3d0900
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB2_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 4000000
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}

define amdgpu_cs void @test_sink_smem_offset_40000000(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX689-LABEL: test_sink_smem_offset_40000000:
; GFX689:       ; %bb.0: ; %entry
; GFX689-NEXT:    s_add_u32 s0, s0, 0x2625a00
; GFX689-NEXT:    s_addc_u32 s1, s1, 0
; GFX689-NEXT:  .LBB3_1: ; %loop
; GFX689-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX689-NEXT:    s_waitcnt lgkmcnt(0)
; GFX689-NEXT:    s_load_dword s3, s[0:1], 0x0
; GFX689-NEXT:    s_add_i32 s2, s2, -1
; GFX689-NEXT:    s_cmp_lg_u32 s2, 0
; GFX689-NEXT:    s_cbranch_scc1 .LBB3_1
; GFX689-NEXT:  ; %bb.2: ; %end
; GFX689-NEXT:    s_endpgm
;
; GFX7-LABEL: test_sink_smem_offset_40000000:
; GFX7:       ; %bb.0: ; %entry
; GFX7-NEXT:  .LBB3_1: ; %loop
; GFX7-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX7-NEXT:    s_waitcnt lgkmcnt(0)
; GFX7-NEXT:    s_load_dword s3, s[0:1], 0x989680
; GFX7-NEXT:    s_add_i32 s2, s2, -1
; GFX7-NEXT:    s_cmp_lg_u32 s2, 0
; GFX7-NEXT:    s_cbranch_scc1 .LBB3_1
; GFX7-NEXT:  ; %bb.2: ; %end
; GFX7-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_40000000:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_add_nc_u64 s[0:1], s[0:1], 0x2625a00
; GFX12-NEXT:  .LBB3_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], 0x0
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB3_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 40000000
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}

define amdgpu_cs void @test_sink_smem_offset_40000000000(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX6789-LABEL: test_sink_smem_offset_40000000000:
; GFX6789:       ; %bb.0: ; %entry
; GFX6789-NEXT:    s_add_u32 s0, s0, 0x502f9000
; GFX6789-NEXT:    s_addc_u32 s1, s1, 9
; GFX6789-NEXT:  .LBB4_1: ; %loop
; GFX6789-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX6789-NEXT:    s_waitcnt lgkmcnt(0)
; GFX6789-NEXT:    s_load_dword s3, s[0:1], 0x0
; GFX6789-NEXT:    s_add_i32 s2, s2, -1
; GFX6789-NEXT:    s_cmp_lg_u32 s2, 0
; GFX6789-NEXT:    s_cbranch_scc1 .LBB4_1
; GFX6789-NEXT:  ; %bb.2: ; %end
; GFX6789-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_40000000000:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:    s_mov_b32 s4, 0x502f9000
; GFX12-NEXT:    s_mov_b32 s5, 9
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_add_nc_u64 s[0:1], s[0:1], s[4:5]
; GFX12-NEXT:  .LBB4_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], 0x0
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB4_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 40000000000
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}

define amdgpu_cs void @test_sink_smem_offset_neg400(ptr addrspace(4) inreg %ptr, i32 inreg %val) {
; GFX678-LABEL: test_sink_smem_offset_neg400:
; GFX678:       ; %bb.0: ; %entry
; GFX678-NEXT:    s_add_u32 s0, s0, 0xfffffe70
; GFX678-NEXT:    s_addc_u32 s1, s1, -1
; GFX678-NEXT:  .LBB5_1: ; %loop
; GFX678-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX678-NEXT:    s_waitcnt lgkmcnt(0)
; GFX678-NEXT:    s_load_dword s3, s[0:1], 0x0
; GFX678-NEXT:    s_add_i32 s2, s2, -1
; GFX678-NEXT:    s_cmp_lg_u32 s2, 0
; GFX678-NEXT:    s_cbranch_scc1 .LBB5_1
; GFX678-NEXT:  ; %bb.2: ; %end
; GFX678-NEXT:    s_endpgm
;
; GFX9-LABEL: test_sink_smem_offset_neg400:
; GFX9:       ; %bb.0: ; %entry
; GFX9-NEXT:  .LBB5_1: ; %loop
; GFX9-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX9-NEXT:    s_waitcnt lgkmcnt(0)
; GFX9-NEXT:    s_load_dword s3, s[0:1], -0x190
; GFX9-NEXT:    s_add_i32 s2, s2, -1
; GFX9-NEXT:    s_cmp_lg_u32 s2, 0
; GFX9-NEXT:    s_cbranch_scc1 .LBB5_1
; GFX9-NEXT:  ; %bb.2: ; %end
; GFX9-NEXT:    s_endpgm
;
; GFX12-LABEL: test_sink_smem_offset_neg400:
; GFX12:       ; %bb.0: ; %entry
; GFX12-NEXT:  .LBB5_1: ; %loop
; GFX12-NEXT:    ; =>This Inner Loop Header: Depth=1
; GFX12-NEXT:    s_waitcnt lgkmcnt(0)
; GFX12-NEXT:    s_load_b32 s3, s[0:1], -0x190
; GFX12-NEXT:    s_add_co_i32 s2, s2, -1
; GFX12-NEXT:    s_delay_alu instid0(SALU_CYCLE_1)
; GFX12-NEXT:    s_cmp_lg_u32 s2, 0
; GFX12-NEXT:    s_cbranch_scc1 .LBB5_1
; GFX12-NEXT:  ; %bb.2: ; %end
; GFX12-NEXT:    s_endpgm
entry:
  %gep = getelementptr i8, ptr addrspace(4) %ptr, i64 -400
  br label %loop

loop:
  %count = phi i32 [ %dec, %loop ], [ %val, %entry ]
  %dec = sub i32 %count, 1
  %load = load volatile i32, ptr addrspace(4) %gep
  %cond = icmp eq i32 %dec, 0
  br i1 %cond, label %end, label %loop

end:
  ret void
}
