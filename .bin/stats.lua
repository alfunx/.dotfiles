#!/usr/bin/env luajit

GTop = require("lgi").GTop
GTop.glibtop_init()

-- MEM

mem = GTop.glibtop_mem()
swap = GTop.glibtop_swap()
GTop.glibtop_get_mem(mem)
GTop.glibtop_get_swap(swap)

local function mb(i)
    return i / (2^10)
end

print()
print("Total:       ", mb(mem.total))
print("Used:        ", mb(mem.used - mem.buffer - mem.cached))
print("Free:        ", mb(mem.free))
print("Shared:      ", mb(mem.shared))
print("Buff/Cache:  ", mb(mem.buffer + mem.cached))
print("Available:   ", mb(mem.total - mem.user))

print()
print("mem:         ", (mem.used - mem.buffer - mem.cached) * 100 / mem.total)

print()
print("swap:        ", mb(swap.total))
print("             ", mb(swap.used))
print("             ", mb(swap.free))

-- CPU

cpu = GTop.glibtop_cpu()
GTop.glibtop_get_cpu(cpu)

print()
print("Total:       ", cpu.total)
print("Idle:        ", cpu.idle)
print("irq:         ", cpu.irq)
print("softirq:     ", cpu.softirq)
print("xcpu_flags:  ", cpu.xcpu_flags)

print()
print("Cores:       ", cpu.xcpu_total[1])
print("             ", cpu.xcpu_total[2])
print("             ", cpu.xcpu_total[3])
print("             ", cpu.xcpu_total[4])
print("             ", cpu.xcpu_total[5])
print("             ", cpu.xcpu_total[6])
print("             ", cpu.xcpu_total[7])
print("             ", cpu.xcpu_total[8])
print("             ", cpu.xcpu_total[9])
print("             ", cpu.xcpu_total[10])

-- SYSDEPS

sysinfo = GTop.glibtop_sysinfo()
GTop.glibtop_get_sysinfo(sysinfo)

print()
print("CPU:         ", sysinfo.ncpu)

GTop.glibtop_close()
