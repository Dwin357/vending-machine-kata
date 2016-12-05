## Vending Machine

#### Install
clone down the repo from github and run ```$ bundle install```.  If you don't have bundler on your machine already, you can find it [here](https://github.com/bundler/bundler).

#### Run Tests
to run all application tests, ```$ bundle exec rspec```.  For specific directories ```$ bundle exec rspec spec/dir-i-want```, and for specific files ```$ bundle exec rspec spec/dir/file-i-want.rb```  

#### Command Line Interface
```$ bundle exec ruby vending-machine-kata/init.rb```

<table>
  <tr>
    <th>command</th><th>alias</th><th>options</th>
  </tr>
  <tr>
    <td>display</td><td>dis</td><td> - </td>
  </tr>
  <tr>
    <td>insert</td><td>in</td><td>-q, -d, -n, -p</td>
  </tr>
  <tr>
    <td>return</td><td>rtn</td><td> - </td>
  </tr>
  <tr>
    <td>cola</td><td>la</td><td> - </td>
  </tr>    
  <tr>
    <td>chips</td><td>ps</td><td> - </td>
  </tr>    
  <tr>
    <td>candy</td><td>dy</td><td> - </td>
  </tr>
  <tr>
    <td>exit</td><td>-e</td><td> - </td>
  </tr>    
  <tr>
    <td>help</td><td>-h</td><td> - </td>
  </tr>    
</table>