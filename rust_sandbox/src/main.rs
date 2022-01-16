use std::collections::HashMap;

fn main() {
    println!("{:?}", two_sum(vec![2, 7, 11, 15], 9));
    println!("{:?}", two_sum(vec![2, 8, 6, 8, 15, 4, 3], 9));
    println!("{:?}", two_sum(vec![3, 2, 4], 6));
}

fn two_sum(nums: Vec<i32>, target: i32) -> Vec<i32> {
    println!("{:?}, {}", nums, target);
    let mut mymap: HashMap<i32, i32> = HashMap::new();
    let mut c = 0;
    for a in nums.iter() {
        match mymap.get(a) {
            Some(b) => {
                return vec![*b, c];
            }
            None => {
                mymap.insert(target - a, c);
                c += 1;
            }
        }
    }
    return vec![1, 2];
}
