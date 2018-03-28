#include <linux/device.h>
#include <linux/types.h>
#include <linux/of.h>
#include <linux/of_device.h>

void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
                        const struct iommu_ops *iommu, bool coherent)
{
        of_dma_configure(dev, NULL);
}
