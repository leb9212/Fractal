__kernel void absolutejulia(
float re_min,
float re_offset,
float re_factor,
float im_min,
float im_offset,
float im_factor,
float scale,
float re_c,
float im_c,
int iter,
__global int *iter_map,
int width)
{
	int gid = get_global_id(0);
	int y = gid % width;
	int x = gid / width;
	float re_z = (re_min + (x + re_offset) * re_factor) / scale;
	float im_z = (im_min + (y - im_offset) * im_factor) / scale;
	float temp;
	int i = -1;
	while (re_z * re_z + im_z * im_z <= 4.0 && ++i < iter)
	{
		temp = fabs(re_z) * fabs(re_z) - fabs(im_z) * fabs(im_z) + re_c;
		im_z = 2 * fabs(re_z) * fabs(im_z) + im_c;
		re_z = temp;
	}
	iter_map[gid] = i;
}
