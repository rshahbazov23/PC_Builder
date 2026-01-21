export interface Category {
  category_id: number;
  name: string;
  slug: string;
  description: string | null;
  icon: string;
}

export interface Product {
  product_id: number;
  category_id: number;
  name: string;
  brand: string;
  model: string | null;
  price: number;
  stock_qty: number;
  power_watts: number;
  rating: number;
  image_url: string | null;
  description: string | null;
  created_at: Date;
  category_name?: string;
  category_slug?: string;
}

export interface User {
  user_id: number;
  username: string;
  email: string;
  created_at: Date;
}

export interface Build {
  build_id: number;
  user_id: number;
  name: string;
  description: string | null;
  created_at: Date;
  updated_at: Date;
}

export type SlotType = 'CPU' | 'GPU' | 'RAM' | 'MOBO' | 'PSU' | 'CASE' | 'STORAGE';

export interface BuildItem {
  build_item_id: number;
  build_id: number;
  product_id: number;
  slot_type: SlotType;
  added_at: Date;
  product?: Product;
}

export interface CPUSpec {
  product_id: number;
  socket: string;
  core_count: number;
  thread_count: number;
  base_clock_ghz: number;
  boost_clock_ghz: number;
  tdp_watts: number;
}

export interface MOBOSpec {
  product_id: number;
  socket: string;
  form_factor: string;
  ram_type: string;
  ram_slots: number;
  max_ram_gb: number;
  pcie_version: string;
}

export interface GPUSpec {
  product_id: number;
  length_mm: number;
  vram_gb: number;
  min_psu_watts: number;
  pcie_version: string;
}

export interface CASESpec {
  product_id: number;
  max_gpu_length_mm: number;
  supported_form_factor: string;
  max_psu_length_mm: number;
  drive_bays_25: number;
  drive_bays_35: number;
}

export interface PSUSpec {
  product_id: number;
  wattage: number;
  efficiency_rating: string;
  modular: string;
  psu_length_mm: number;
}

export interface RAMSpec {
  product_id: number;
  ram_type: string;
  speed_mhz: number;
  size_gb: number;
  modules: number;
  latency: string;
}

export interface StorageSpec {
  product_id: number;
  storage_type: string;
  capacity_gb: number;
  form_factor: string;
  read_speed_mbps: number;
  write_speed_mbps: number;
}

export interface ProductWithSpecs extends Product {
  specs?: CPUSpec | MOBOSpec | GPUSpec | CASESpec | PSUSpec | RAMSpec | StorageSpec;
}

export interface BuildSummary {
  build_id: number;
  build_name: string;
  user_id: number;
  part_count: number;
  total_price: number;
  total_watts: number;
  items: BuildItemWithProduct[];
  compatibility_issues: string[];
}

export interface BuildItemWithProduct extends BuildItem {
  name: string;
  brand: string;
  model: string | null;
  price: number;
  stock_qty: number;
  power_watts: number;
  rating: number;
  image_url: string | null;
  category_name?: string;
  category_slug?: string;
  specs?: CPUSpec | MOBOSpec | GPUSpec | CASESpec | PSUSpec | RAMSpec | StorageSpec;
}

export interface ProductFilters {
  category?: string;
  brand?: string;
  q?: string;
  minPrice?: number;
  maxPrice?: number;
  minRating?: number;
  inStock?: boolean;
  sort?: 'rating_desc' | 'price_asc' | 'price_desc' | 'name_asc' | 'newest' | 'stock_desc';
  limit?: number;
  offset?: number;
}

export interface TopBrand {
  category: string;
  brand: string;
  num_products: number;
  avg_rating: number;
}

export interface Deal extends Product {
  category: string;
  savings: number;
  category_avg: number;
}


