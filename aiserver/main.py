import torch

print("CUDA Available:", torch.cuda.is_available())
print("Device Name:", torch.cuda.get_device_name(0))

x = torch.tensor([1.0, 2.0, 3.0]).cuda()
y = torch.tensor([9.0, 8.0, 7.0]).cuda()
z = x + y

print("Result:", z)
