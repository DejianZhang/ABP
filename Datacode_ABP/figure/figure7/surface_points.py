import open3d as o3d
import numpy as np



pcd = o3d.io.read_point_cloud('NCU.ply')

vis = o3d.visualization.Visualizer()
vis.create_window(window_name='NCU', width=800, height=600)

opt = vis.get_render_option()
opt.background_color = np.asarray([0, 0, 0])
opt.point_size = 10
vis.add_geometry(pcd)
vis.run()
vis.destroy_window()











